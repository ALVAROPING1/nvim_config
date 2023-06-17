local M = {}

--- Snippet object
---@class Snippet
---@field snippet self Surrounding snippet
---@field captures string[] Captures of the snippet
---@field env {string: string} Environment variables of the snippet

--- Snippet node object
---@class Node
---@field snippet Snippet Surrounding snippet

local ls = require("luasnip")

M.snippet = ls.snippet
M.autosnippet = ls.extend_decorator.apply(M.snippet, { snippetType = "autosnippet" })
-- M.multisnippet = ls.multi_snippet -- Not yet in the stable version of luasnip

M.node = {
    snippet = ls.snippet_node,
    indent_snippet = ls.indent_snippet_node,
    txt = ls.text_node,
    ins = ls.insert_node,
    fn = ls.function_node,
    choice = ls.choice_node,
    dynamic = ls.dynamic_node,
    restore = ls.restore_node,
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

M.conds = require("luasnip.extras.expand_conditions")
M.postfix = require("luasnip.extras.postfix").postfix
-- M.types = require("luasnip.util.types")
-- M.key = require("luasnip.nodes.key_indexer").new_key -- Not yet in the stable version of luasnip

return M
