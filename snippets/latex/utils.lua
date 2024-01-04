local ls = require("user.snippets.luasnips")
local parse_snippet = ls.parse_snippet
local multi_snippet = ls.multi_snippet
local fmt = ls.fmt

local M = {}

--- Snippet condition checking that the matched trigger is the beginning of a command without a "\"
---@return boolean
M.command_begin = ls.conds.make(function(line, matched)
    local pos = #line - #matched
    return line:sub(pos, pos):match("[^\\]") and line:sub(pos + 1, pos + 1):match("[^\\]")
end)

--- Creates snippets for the given command
---@param spec SnippetSpec
---@param format string Format string for the command and its parameters
---@param nodes Node[] Node list to use
---@param text boolean? Whether the snippet will be available inside math environment or text environment (math by default)
---@return Snippet # Created snippets
function M.create_snippet(spec, format, nodes, text)
    local condition = text and M.command_begin or M.command_begin -- TODO:
    if type(spec) == "string" then
        spec = { spec }
    end

    return multi_snippet({
        common = { name = spec[2] or spec[1], condition = condition },
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
---@param group SnippetSpec[]
---@param suffix string Suffix format string to append after the command name
---@param nodes fun(): Node[] Function creating the node list to use
function M.add_snippet_group(snippets, group, suffix, nodes)
    for _, spec in ipairs(group) do
        local cmd = type(spec) == "string" and spec or spec[1]
        table.insert(snippets, M.create_snippet(spec, "\\" .. cmd .. suffix, nodes()))
    end
end

--- Creates an environment snippet
---@param spec SnippetSpec
---@param envs string[] | string List of allowed environments (first will be selected by default). If it's a single value, that environment will be selected
---@return Snippet
function M.environment_snippet(spec, envs)
    return M.create_snippet(
        spec,
        "\\begin{<>}\n\t<>\n\\end{<>}",
        parse_snippet(
            nil,
            type(envs) == "table" and string.format("${1|%s|}$2$1", table.concat(envs, ",")) or envs .. "$1" .. envs
        )
    )
end

return M
