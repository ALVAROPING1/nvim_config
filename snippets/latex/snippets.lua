---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("user.snippets.luasnips")
local autosnippet = ls.autosnippet
local node = ls.node
local extras = ls.extras
local fmt = ls.fmt
local postfix = ls.postfix

---------------------------------------------------------------------------------------------------------------------------------
--- Personal imports
---------------------------------------------------------------------------------------------------------------------------------

local data = require("user.snippets.latex.data")
local cmds = data.cmds
local functions = data.functions
local limit_operators = data.limit_operators
local int = data.int
local limit = data.limit
local FORMAT_ENV = data.envs.FORMAT
local envs = data.envs.math
local txt_autosnippets = data.txt_autosnippets
local postfix_autosnippets = data.postfix_autosnippets

local utils = require("user.snippets.utils")
local COMMAND_BEGIN_CONDITION = utils.COMMAND_BEGIN_CONDITION
local get_capture = utils.get_capture
local create_text_nodes = utils.create_text_nodes
local create_fn_node = utils.create_fn_node
local create_snippet = utils.create_snippet
local add_snippet_group = utils.add_snippet_group

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

local M = {}

-- Create snippets based on the commands in cmds
for num_params, command_groups in ipairs(cmds) do
    local params = string.rep("{<>}", num_params - 1)
    for _, command_group in pairs(command_groups) do
        add_snippet_group(M, command_group, params, function()
            return { node.ins(1), node.ins(2), node.ins(3) }
        end)
    end
end

-- Create function snippets
add_snippet_group(M, functions, "(<>)", function()
    return { node.ins(1) }
end)

-- Create snippets for operators with limits
add_snippet_group(M, limit_operators, "<>{<>}", function()
    return {
        node.choice(1, {
            fmt("_<>", { node.ins(1) }),
            fmt("_{<> = <>}", { node.ins(1, "i"), node.ins(2, "0") }),
            fmt("_{<> = <>}^<>", { node.ins(1, "i"), node.ins(2, "0"), node.ins(3, "\\infty") }),
        }),
        node.choice(2, { node.restore(1, "x"), fmt("\\left( <> \\right)", { node.restore(1, "x") }) }),
    }
end)

vim.list_extend(
    M,
    create_snippet(int, true, "\\" .. int[1] .. "<>{<> d<>}", function()
        return {
            node.choice(1, {
                node.txt(""),
                fmt("_<>^<>", { node.ins(1), node.ins(2) }),
            }),
            node.ins(2),
            node.ins(3),
        }
    end)
)

vim.list_extend(
    M,
    create_snippet(limit, true, "\\" .. limit[1] .. "_{<> \\to <>}{<>}", function()
        return { node.ins(1, "x"), node.ins(2, "\\infty"), node.ins(3) }
    end)
)

-- Create environment snippets
vim.list_extend(
    M,
    create_snippet({ "begin", "Begin environment (generic)", "beg" }, false, FORMAT_ENV, function()
        return { node.choice(1, create_text_nodes(envs)), node.ins(2), extras.dup(1) }
    end)
)
vim.list_extend(
    M,
    create_snippet({ "aligned", "Begin environment (aligned)", "ali" }, false, FORMAT_ENV, function()
        return { node.txt("aligned"), node.ins(1), node.txt("aligned") }
    end)
)

-- Create text autosnippets
for trig, spec in pairs(txt_autosnippets) do
    vim.list_extend(M, { autosnippet({ trig = trig, wordTrig = false, name = spec[2], dscr = "" }, node.txt(spec[1])) })
end

-- Create postfix autosnippets
for trig, spec in pairs(postfix_autosnippets) do
    vim.list_extend(M, {
        postfix(
            { trig = trig, name = spec[2], dscr = "", snippetType = "autosnippet", priority = 800 },
            fmt("\\" .. spec[1] .. "{<>}", { create_fn_node(get_capture, { "POSTFIX_MATCH" }) })
        ),
    })
end

-- Create subscript autosnippets
for _, key in ipairs({ "i", "j", "k", "n", "m" }) do
    vim.list_extend(M, {
        autosnippet(
            { trig = "([xyzt])" .. key:rep(2), regTrig = true, name = "Auto subscript", dscr = "" },
            fmt("<>_" .. key, { create_fn_node(get_capture, { 1 }) }),
            COMMAND_BEGIN_CONDITION
        ),
    })
end

-- Create custom autosnippets
vim.list_extend(M, {
    -- Set
    autosnippet(
        { trig = "set", name = "Set", dscr = "Create a set" },
        fmt("\\{<>\\}", { node.ins(1) }),
        COMMAND_BEGIN_CONDITION
    ),
    -- Toggle parenthesis
    autosnippet(
        { trig = "()", name = "Parenthesis", dscr = "Toggle parenthesis size" },
        node.choice(1, { fmt("(<>)", node.restore(1, "x")), fmt("\\left( <> \\right)", node.restore(1, "x")) }),
        COMMAND_BEGIN_CONDITION
    ),
    -- Auto subscripts
    autosnippet(
        { trig = "(%a)(%d)", regTrig = true, name = "Auto subscript", dscr = "" },
        fmt("<>_<>", { create_fn_node(get_capture, { 1 }), create_fn_node(get_capture, { 2 }) }),
        COMMAND_BEGIN_CONDITION
    ),
    autosnippet(
        { trig = "(%a)_(%d%d)", regTrig = true, name = "Auto subscript", dscr = "" },
        fmt("<>_{<>}", { create_fn_node(get_capture, { 1 }), create_fn_node(get_capture, { 2 }) }),
        COMMAND_BEGIN_CONDITION
    ),
    -- Subscript/Superscript
    autosnippet({ trig = "ss", wordTrig = false, name = "Subscript", dscr = "" }, fmt("_{<>}", { node.ins(1) })),
    autosnippet({ trig = "SS", wordTrig = false, name = "Superscript", dscr = "" }, fmt("^{<>}", { node.ins(1) })),
    -- Automatic fractions
    autosnippet(
        { trig = "(%b())/", regTrig = true, name = "Automatic fraction", dscr = "" },
        fmt("\\frac{<>}{<>}", { create_fn_node(get_capture, { 1, { 1, 1 } }), node.ins(1) })
    ),
    autosnippet(
        { trig = "(%d+)/", regTrig = true, name = "Automatic fraction", dscr = "" },
        fmt("\\frac{<>}{<>}", { create_fn_node(get_capture, { 1 }), node.ins(1) })
    ),
    autosnippet(
        { trig = "//", name = "Fraction", dscr = "" },
        fmt("\\frac{<>}{<>}", {
            node.dynamic(1, function(_, parent)
                if parent.snippet.env.LS_SELECT_RAW[1] ~= nil then
                    return node.snippet(nil, node.txt(parent.snippet.env.LS_SELECT_RAW))
                end
                return node.snippet(nil, node.ins(1))
            end),
            node.ins(2),
        })
    ),
})

return M
