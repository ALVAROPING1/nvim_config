local ls = require("snippets.luasnips")
local parse_snippet = ls.parse_snippet
local multi_snippet = ls.multi_snippet
local fmt = ls.fmt

local M = {}

--- Map of nodes to their associated behaviour:
--- - `boolean`: Result of the search
--- - `string`: enter the child tree with this name
--- - `nil`: ignore the node and continue searching upwards through the current language's tree
--- - `function`: execute the function to determine the behaviour. Returns one of the previous values
---@alias TSNodeBehaviourMap {[string]: (boolean | string | fun(node: TSNode): ((boolean | string)?))?}

--- Map of languages to their associated node behaviour map
---@alias LanguageBehaviourMap {[string]: TSNodeBehaviourMap?}

--- Traverses the treesitter tree searching for a node satisfying a condition
---@param lang_map LanguageBehaviourMap
---@param start_leaf true? Whether the starting language should be a leaf at the cursor
---@return boolean
local function traverse(lang_map, start_leaf)
    local lang_tree = vim.treesitter.get_parser()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local range = { cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] }
    lang_tree = start_leaf and lang_tree:language_for_range(range) or lang_tree
    local node_map = lang_map[lang_tree:lang()]
    local node = lang_tree:named_node_for_range(range)
    while node and node_map and lang_tree do
        local check = node_map[node:type()]
        -- The function/`check` might return `nil`/`false`, so wrap the results in a table and get the element later
        check = (type(check) == "function" and { check(node) } or { check })[1]
        ---@cast check -function LuaLS can't figure out that `check` can no longer be a function after this
        if type(check) == "boolean" then
            return check
        end
        node = node:parent()
        if check ~= nil then
            lang_tree = lang_tree:children()[check]
            node_map, node =
                unpack(lang_tree and { lang_map[lang_tree:lang()], lang_tree:named_node_for_range(range) } or {})
        end
    end
    return false
end

--- Creates a condition to traverse the treesitter tree searching for a node satisfying a condition, caching the result
---@param nodes LanguageBehaviourMap
---@param start_leaf true? Whether the starting language should be a leaf at the cursor
---@return SnippetConditionObject
local function traverse_cond(nodes, start_leaf)
    local value, pos = false, { -1, -1 }
    return ls.conds.make(function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        -- The cache is valid if the cursor hasn't moved
        if pos[1] == cursor[1] and pos[2] == cursor[2] then
            return value
        end
        -- If the cache is invalid, calculate the result again and update it before returning the result
        pos = cursor
        value = traverse(nodes, start_leaf)
        return value
    end)
end

--- Creates a condition checking if the cursor in the specified environment
---@param environment string
---@return SnippetConditionObject
function M.in_environment(environment)
    return traverse_cond({
        latex = {
            generic_environment = function(node)
                node = node:named_child(0):named_child(0):named_child(0) --[[@as TSNode]]
                return vim.treesitter.get_node_text(node, 0) == environment
            end,
        },
    }, true)
end

--- Snippet condition checking whether the cursor is in a math environment or not
M.in_math = traverse_cond({
    latex = {
        displayed_equation = true,
        inline_formula = true,
        math_environment = true,
        text_mode = false,
    },
    markdown_inline = { latex_block = true },
    markdown = {
        inline = "markdown_inline",
        fenced_code_block = function(node)
            return vim.treesitter.get_node_text(node:named_child(1) --[[@as TSNode]], 0)
        end,
    },
    norg = {
        inline_math = true,
        ranged_verbatim_tag = function(node)
            local name_node = node:field("name")[1]
            local name = vim.treesitter.get_node_text(name_node, 0)
            return name == "math"
                or ({ code = true, embed = true })[name]
                and vim.treesitter.get_node_text(name_node:next_named_sibling() --[[@as TSNode]], 0)
        end,
    },
})
-- Shorthand for `NOT in_math`
M.in_text = -M.in_math

--- Creates snippets for the given command
---@param spec SnippetSpec
---@param format string Format string for the command and its parameters
---@param nodes Node[] Node list to use
---@param text true? Whether the snippet will be available inside math or text environment (math by default). The value in `spec` takes precedence
---@return Snippet # Created snippets
function M.create_snippet(spec, format, nodes, text)
    text = spec.text == nil and text or spec.text
    local cond = text and M.in_text or M.in_math
    spec = type(spec) == "string" and { spec } or spec

    local contexts = {
        common = { name = spec[2] or spec[1], condition = cond, show_condition = cond },
        spec[3] and {
            trig = type(spec[3]) == "number" and spec[spec[3]] or spec[3],
            priority = spec.priority,
            snippetType = "autosnippet",
        } or nil,
    }
    if spec[3] ~= 1 then
        table.insert(contexts, { trig = spec[1] })
    end
    return multi_snippet(contexts, fmt(format, nodes, { strict = false, trim_empty = false }))
end

--- Creates snippets from the given table
---@param snippets Snippet[] List of snippets in which the newly created ones should be appended
---@param group SnippetGroup
---@param suffix string Suffix format string to append after the command name
---@param nodes fun(): Node[] Function creating the node list to use
function M.add_snippet_group(snippets, group, suffix, nodes)
    for _, spec in ipairs(group) do
        local cmd = type(spec) == "string" and spec or spec[1]
        table.insert(snippets, M.create_snippet(spec, "\\" .. cmd .. suffix, nodes(), group.text))
    end
end

--- Creates an environment snippet
---@param spec SnippetSpec
---@param envs string[] | string List of allowed environments (first will be selected by default). If it's a single value, that environment will be selected
---@param text true? Whether the snippet will be available inside math or text environment (math by default). The value in `spec` takes precedence
---@return Snippet
function M.environment_snippet(spec, envs, text)
    return M.create_snippet(
        spec,
        "\\begin{<>}\n\t<>\n\\end{<>}",
        parse_snippet(
            nil,
            type(envs) == "table" and string.format("${1|%s|}$2$1", table.concat(envs, ",")) or envs .. "$1" .. envs
        ),
        text
    )
end

return M
