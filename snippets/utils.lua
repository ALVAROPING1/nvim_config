local ls = require("user.snippets.luasnips")
local snippet = ls.snippet
local autosnippet = ls.autosnippet
local node = ls.node
local fmt = ls.fmt

local M = {}

--- Opts table with snippet condition checking that the matched trigger is the beginning of a command without a "\"
M.COMMAND_BEGIN_CONDITION = {
    ---@param line string Line up until the cursor position
    ---@param matched string Matched string
    ---@return boolean
    condition = function(line, matched)
        local pos = #line - #matched
        -- print(matched)
        return pos == 0 or line:sub(pos, pos):match("[^\\%w]")
    end,
}

--- Returns the Nth capture group of a snippet, optionally removing the first/last characters
---@param _ _
---@param parent Snippet | Node Parent of the function node
---@param arg1 integer | string Capture group number or environment variable name
---@param arg2 {[1]: integer, [2]: integer}? Number of characters to remove from the start/end of the capture
---@return string
function M.get_capture(_, parent, arg1, arg2)
    local out
    if type(arg1) == "string" then
        out = parent.snippet.env[arg1]
    else
        out = parent.snippet.captures[arg1]
    end
    if arg2 ~= nil then
        out = out:sub(1 + arg2[1], #out - arg2[2])
    end
    return out
end

--- Create list of text nodes with each of the input values
---@param values string[]
---@return Node[]
function M.create_text_nodes(values)
    local nodes = {}
    for _, value in ipairs(values) do
        vim.list_extend(nodes, { node.txt(value) })
    end
    return nodes
end

--- Creates a function node with no node references
---@param fn fun(_: _, parent: Snippet | Node, args: any[]): string Function to run in the node
---@param args any[] Arguments of the function
---@return Node
function M.create_fn_node(fn, args)
    return node.fn(fn, {}, { user_args = args })
end

--- Creates snippets for the given command
---@param spec SnippetSpec
---@param format string Format string for the command and its parameters
---@param nodes fun(): Node[] Function creating the node list to use
---@return { [1]: Snippet, [2]: Snippet?, [3]: Snippet? } # Created snippets
function M.create_snippet(spec, format, nodes)
    if type(spec) == "string" then
        spec = { spec }
    end
    local name = spec[2] or spec[1]
    local auto_trig = type(spec[3]) == "number" and spec[spec[3]] or spec[3]

    return {
        snippet(
            { trig = "\\" .. spec[1], name = name, dscr = "" },
            fmt(format, nodes(), { strict = false, trim_empty = false })
        ),
        spec[3] and autosnippet(
            { trig = auto_trig, name = name, dscr = "", priority = spec.priority, wordTrig = false },
            fmt(format, nodes(), { strict = false, trim_empty = false }),
            M.COMMAND_BEGIN_CONDITION
        ),
    }
end

--- Creates snippets from the given table
---@param snippets Snippet[] List of snippets in which the newly created ones should be appended
---@param group SnippetGroup
---@param params string Parameters format string to append after the command name
---@param nodes fun(): Node[] Function creating the node list to use
function M.add_snippet_group(snippets, group, params, nodes)
    for _, spec in ipairs(group) do
        local cmd = type(spec) == "string" and spec or spec[1]
        vim.list_extend(snippets, M.create_snippet(spec, "\\" .. cmd .. params, nodes))
    end
end

return M

---@class SnippetSpecTable
---@field [1] string Command
---@field [2] string? Name, if `nil` the command should be used
---@field [3] (string | 1 | 2)? Autosnippet trigger, if a number the field indicated by that number should be used. If nil no autosnippet should be created
---@field priority number? Priority of the snippet

--- Definition an snippet with an optional autosnippet
---@alias SnippetSpec (string | SnippetSpecTable)

--- Group of snippet specs
---@alias SnippetGroup SnippetSpec[]

--- Definition of an autosnippet
--- Format: `{text, name}`
---@alias AutoSnippetSpec {[1]: string, [2]: string}

--- List of `AutoSnippetSpec`'s. The keys are the triggers
---@alias AutoSnippetSpecs {[string]: AutoSnippetSpec}
