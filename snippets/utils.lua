local ls = require("user.snippets.luasnips")
local snippet = ls.snippet
local autosnippet = ls.autosnippet
local node = ls.node
local fmt = ls.fmt

local M = {}

--- Opts table with snippet condition checking that the matched trigger is the beggining of a command without a "\"
M.COMMAND_BEGIN_CONDITION = {
    ---@param line string Line up until the cursor position
    ---@param matched string Matched string
    ---@return boolean
    condition = function(line, matched)
        local pos = #line - #matched
        -- print(matched)
        return pos == 0 or line:sub(pos, pos):match("[^\\]")
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
---@param spec SnippetSpec Spec defining the snippet to create
---@param auto boolean Whether an autosnippet should be created for the cmd
---@param format string Format string for the command and its parameters
---@param nodes fun(): Node[] Function creating the node list to use
---@return { [1]: Snippet, [2]: Snippet?, [3]: Snippet? } # Created snippets
function M.create_snippet(spec, auto, format, nodes)
    if type(spec) == "string" then
        spec = { spec }
    end
    local name = spec[2] or spec[1]

    local function create_autosnippet(trig, default)
        if trig then
            if type(trig) == "boolean" then
                trig = default
            end
            return autosnippet(
                { trig = trig, name = name, dscr = "", priority = spec.priority },
                fmt(format, nodes(), { strict = false, trim_empty = false }),
                M.COMMAND_BEGIN_CONDITION
            )
        end
    end

    return {
        snippet(
            { trig = "\\" .. spec[1], name = name, dscr = "" },
            fmt(format, nodes(), { strict = false, trim_empty = false })
        ),
        create_autosnippet(auto, spec[1]),
        create_autosnippet(spec[3], spec[2]),
    }
end

--- Creates snippets from the given table
---@param snippets Snippet[] List of snippets in which the newly created ones should be appended
---@param group SnippetGroup Group of commands for which to create snippets
---@param params string Parameters format string to append after the command name
---@param nodes fun(): Node[] Function creating the node list to use
function M.add_snippet_group(snippets, group, params, nodes)
    for auto, list in pairs(group) do
        for _, spec in ipairs(list) do
            local cmd = type(spec) == "string" and spec or spec[1]
            vim.list_extend(snippets, M.create_snippet(spec, auto, "\\" .. cmd .. params, nodes))
        end
    end
end

return M

--- Format: `cmd | {cmd, [name, [shortcut | true]], [priority = number]}`
---@alias SnippetSpec string | {[1]: string, [2]: string?, [3]: (string | true)?, priority: number}

--- List of `SnippetSpec`'s
---@class SnippetSpecs
---@field [integer] SnippetSpec

--- Group of snippet specs. The key indicates whether they should also define an autosnippet or not
---@class SnippetGroup
---@field [boolean] SnippetSpecs

--- Definition of an autosnippet
--- Format: `{text, name}`
---@alias AutoSnippetSpec {[1]: string, [2]: string}

--- List of `AutoSnippetSpec`'s. The keys are the triggers
---@alias AutoSnippetSpecs {[string]: AutoSnippetSpec}
