local ls = require("user.snippets.luasnips")
local parse_snippet = ls.parse_snippet
local multi_snippet = ls.multi_snippet
local fmt = ls.fmt

local M = {}

--- Map of nodes to their associated behaviour:
--- - `boolean`: whether the node is a math environment or not. Ends the search
--- - `string`: restart the search using the value as the language
--- - `nil`: ignore the node and continue searching upwards
--- - `function`: execute the function to determine the behaviour. Returns one of the previous values
---@alias TSNodeBehaviourMap {[string]: (boolean | string | fun(node: TSNode): (boolean | string)?)?}

--- Traverses the treesitter tree searching for a node satisfying a condition
---@param nodes TSNodeBehaviourMap
---@param lang string? Starting treesitter language (current by default)
---@return boolean
local function traverse(nodes, lang)
    local node = vim.treesitter.get_node({ lang = lang })
    local depth = 0
    while node do
        local check = nodes[node:type()]
        -- The function/`check` might return `nil`/`false`, so wrap the results in a table and get the element later
        check = (type(check) == "function" and { check(node) } or { check })[1]
        ---@cast check -function LuaLS can't figure out that `check` can no longer be a function after this
        if type(check) == "boolean" then
            return check
        end
        ---@cast check -boolean LuaLS can't figure out that `check` can no longer be a `bool` after this
        local parent = node:parent()
        node = (check ~= nil and parent ~= nil) and vim.treesitter.get_node({ lang = check }) or parent
        depth = depth + 1
        assert(depth < 25, "Error checking if in math zone: Too many nesting levels found (probably infinite loop)")
    end
    return false
end

--- Creates a condition to traverse the treesitter tree searching for a node satisfying a condition, caching the result
---@param nodes TSNodeBehaviourMap
---@param lang string? Starting treesitter language (current by default)
---@return SnippetConditionObject
local function traverse_cond(nodes, lang)
    local value, pos = false, { -1, -1 }
    return ls.conds.make(function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        -- The cache is valid if the cursor hasn't moved
        if pos[1] == cursor[1] and pos[2] == cursor[2] then
            return value
        end
        -- If the cache is invalid, calculate the result again and update it before returning the result
        pos = cursor
        value = traverse(nodes, lang)
        return value
    end)
end

-- Map of languages to their treesitter parser name
-- HACK: `markdown` isn't parsed well when injected, so skip directly to `markdown_inline`
local INJECTION_LANGS =
{ latex = "latex", markdown = "markdown_inline", markdown_inline = "markdown_inline", norg = "norg" }

--- Snippet condition checking whether the cursor is in a math environment or not
M.in_math = traverse_cond({
    -- Latex
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
    text_mode = false,
    -- Markdown
    latex_block = true,
    inline = "markdown_inline",
    fenced_code_block = function(node)
        local lang = vim.treesitter.get_node_text(node:named_child(1), 0)
        return INJECTION_LANGS[lang] or false
    end,
    -- Neorg
    inline_math = true,
    ranged_verbatim_tag = function(node)
        ---@diagnostic disable-next-line: undefined-field # Field exists, but the type annotation isn't in neovim 0.9.5. TODO: remove after neovim 0.10 is stable
        local name_node = node:field("name")[1]
        local name = vim.treesitter.get_node_text(name_node, 0)
        if name == "math" then
            return true
        end
        if ({ code = true, embed = true })[name] then
            local lang = vim.treesitter.get_node_text(name_node:next_named_sibling(), 0)
            return INJECTION_LANGS[lang] or false
        end
        return false
    end,
})
-- Shorthand for `NOT in_math`
M.in_text = -M.in_math

--- Snippet condition checking that the matched trigger is the beginning of a command without a "\"
M.command_begin = ls.conds.make(function(line, matched)
    local pos = #line - #matched
    return (pos == 0 or line:sub(pos, pos):match("[^\\]")) and line:sub(pos + 1, pos + 1):match("[^\\]")
end)

-- Shorthand for `command_begin AND in_math`
M.math_command = M.command_begin * M.in_math
-- Shorthand for `command_begin AND in_text`
M.text_command = M.command_begin - M.in_math

--- Creates snippets for the given command
---@param spec SnippetSpec
---@param format string Format string for the command and its parameters
---@param nodes Node[] Node list to use
---@param text true? Whether the snippet will be available inside math or text environment (math by default). The value in `spec` takes precedence
---@return Snippet # Created snippets
function M.create_snippet(spec, format, nodes, text)
    text = spec.text == nil and text or spec.text
    local conds = text and { M.text_command, M.in_text } or { M.math_command, M.in_math }
    if type(spec) == "string" then
        spec = { spec }
    end

    return multi_snippet({
        common = { name = spec[2] or spec[1], condition = conds[1], show_condition = conds[2] },
        { trig = "\\" .. spec[1] },
        spec[3] and {
            trig = type(spec[3]) == "number" and spec[spec[3]] or spec[3],
            priority = spec.priority,
            snippetType = "autosnippet",
        } or nil,
    }, fmt(format, nodes, { strict = false, trim_empty = false }))
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
