local M = {}

--- Snippet object
---@class Snippet
---@field snippet self Surrounding snippet
---@field captures string[] Captures of the snippet
---@field env {string: string} Environment variables of the snippet

--- Snippet node object
---@class Node
---@field snippet Snippet Surrounding snippet

--- Snippet condition function
---@alias SnippetConditionFunction fun(line: string, matched: string, captures: string[]): boolean

--- Snippet condition object
---@class SnippetConditionObject
---@operator unm(SnippetConditionObject): SnippetConditionObject NOT
---@operator mul(SnippetConditionObject): SnippetConditionObject AND
---@operator add(SnippetConditionObject): SnippetConditionObject OR
---@operator sub(SnippetConditionObject): SnippetConditionObject AND NOT
---@operator pow(SnippetConditionObject): SnippetConditionObject XOR (!=)
---@operator mod(SnippetConditionObject): SnippetConditionObject XNOR (==)

--- Snippet condition
---@alias SnippetCondition SnippetConditionObject | SnippetConditionFunction

local ls = require("luasnip")

M.snippet = ls.snippet
M.parse_snippet = ls.parser.parse_snippet
M.multi_snippet = ls.multi_snippet

M.node = {
    snippet = ls.snippet_node,
    indent_snippet = ls.indent_snippet_node,
    txt = ls.text_node,
    ins = ls.insert_node,
    fn = ls.function_node,
    choice = ls.choice_node,
    dynamic = ls.dynamic_node,
    restore = ls.restore_node,
    --- Returns the Nth capture group of a snippet, optionally removing the first/last characters
    ---@param capture integer | string Capture group number or environment variable name
    ---@param trim {[1]: integer, [2]: integer}? Number of characters to remove from the start/end of the capture
    ---@return string
    capture = function(capture, trim)
        ---@param parent Snippet | Node
        return ls.function_node(function(_, parent)
            local out = parent.snippet[type(capture) == "string" and "env" or "captures"][capture]
            if trim ~= nil then
                out = out:sub(1 + trim[1], #out - trim[2])
            end
            return out
        end, {})
    end
}

M.events = require("luasnip.util.events")

local extras = require("luasnip.extras")
M.extras = {
    lambda = extras.lambda,
    dup = extras.rep,
    partial = extras.partial,
    match = extras.match,
    nonempty = extras.nonempty,
    dynamic_lambda = extras.dynamic_lambda,
}
M.fmt = require("luasnip.extras.fmt").fmta

M.conds = {
    expand = require("luasnip.extras.conditions.expand"),
    show = require("luasnip.extras.conditions.show"),
    ---@type fun(condition: SnippetConditionFunction): SnippetConditionObject
    make = require("luasnip.extras.conditions").make_condition,
}
M.postfix = require("luasnip.extras.postfix").postfix
-- M.key = require("luasnip.nodes.key_indexer").new_key -- Not yet in the stable version of luasnip

return M
