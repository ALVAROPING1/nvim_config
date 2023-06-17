---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------
local ls = require("user.snippets.luasnips")
local snippet = ls.snippet
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
local envs = data.envs
local txt_autosnippets = data.txt_autosnippets
local postfix_autosnippets = data.postfix_autosnippets

local utils = require("user.snippets.utils")
local COMMAND_BEGIN_CONDITION = utils.COMMAND_BEGIN_CONDITION
local get_capture = utils.get_capture
local create_text_nodes = utils.create_text_nodes
local create_fn_node = utils.create_fn_node

---------------------------------------------------------------------------------------------------------------------------------
--- Utils
---------------------------------------------------------------------------------------------------------------------------------

--- Creates snippets for the given command
---@param trigger {[1]: string, [2]: boolean | string, [3]: boolean | string} Trigger strings. The second/third value determines whether an autosnippet/shortcut should be created. If they are strings, they will be used as the autosnippet/shortcut's trigger. If they are boolean, the first trigger is used for the autosnippet and the name is used for the shortcut
---@param name string? Command name. If nil, the first trigger is used
---@param format string Format string for the command and its parameters
---@param nodes fun(): Node[] Function creating the node list to use
---@param priority number? Priority of the autosnippets
---@return { [1]: Snippet, [2]: Snippet? } # Created snippets
local function create_snippets(trigger, name, format, nodes, priority)
    local function create_autosnippet(trig, default)
        if trig then
            if type(trig) == "boolean" then
                trig = default
            end
            return autosnippet(
                { trig = trig, name = name, dscr = "", priority = priority },
                fmt(format, nodes(), { strict = false, trim_empty = false }),
                COMMAND_BEGIN_CONDITION
            )
        end
    end

    name = name or trigger[1]
    return {
        snippet(
            { trig = "\\" .. trigger[1], name = name, dscr = "" },
            fmt(format, nodes(), { strict = false, trim_empty = false })
        ),
        create_autosnippet(trigger[2], trigger[1]),
        create_autosnippet(trigger[3], name),
    }
end

--- Creates snippets from the given table
---@param snippets Snippet[] List of snippets in which the newly created ones should be appended
---@param group SnippetGroup Group of commands for which to create snippets
---@param params string Parameters format string to append after the command name
---@param nodes fun(): Node[] Function creating the node list to use
local function add_snippets(snippets, group, params, nodes)
    for auto, list in pairs(group) do
        for _, command in ipairs(list) do
            local cmd = command
            local name = command
            ---@type string | boolean
            local shortcut = false
            local priority = nil
            if type(command) == "table" then
                cmd = command[1]
                name = command[2]
                shortcut = command[3] or false
                priority = command.priority
            end
            vim.list_extend(
                snippets,
                ---@diagnostic disable-next-line: param-type-mismatch, assign-type-mismatch
                create_snippets({ cmd, auto, shortcut }, name, "\\" .. cmd .. params, nodes, priority)
            )
        end
    end
end

local FORMAT_ENV = "\\begin{<>}\n\t<>\n\\end{<>}"

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

local M = {}

-- Create snippets based on the commands in cmds
for num_params, command_groups in ipairs(cmds) do
    local params = string.rep("{<>}", num_params - 1)
    for _, command_group in pairs(command_groups) do
        add_snippets(M, command_group, params, function()
            return { node.ins(1), node.ins(2), node.ins(3) }
        end)
    end
end

-- Create function snippets
add_snippets(M, functions, "(<>)", function()
    return { node.ins(1) }
end)

-- Create snippets for operators with limits
add_snippets(M, limit_operators, "<>{<>}", function()
    return {
        node.choice(1, {
            fmt("_<>", { node.ins(1) }),
            fmt("_{<> = <>}", { node.ins(1, "i"), node.ins(2, "0") }),
            fmt("_{<> = <>}^<>", { node.ins(1, "i"), node.ins(2, "0"), node.ins(3, "\\infty") }),
        }),
        node.choice(2, { node.ins(), fmt("\\left( <> \\right)", { node.ins(1) }) }),
    }
end)

vim.list_extend(
    M,
    create_snippets({ int[1], true }, int[2], "\\" .. int[1] .. "<>{<> d<>}", function()
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
    create_snippets({ limit[1], true }, limit[2], "\\" .. limit[1] .. "_{<> \\to <>}{<>}", function()
        return { node.ins(1, "x"), node.ins(2, "\\infty"), node.ins(3) }
    end)
)

-- Create environment snippets
vim.list_extend(
    M,
    create_snippets({ "begin", "beg" }, "Begin environment (generic)", FORMAT_ENV, function()
        return { node.choice(1, create_text_nodes(envs)), node.ins(2), extras.dup(1) }
    end)
)
vim.list_extend(
    M,
    create_snippets({ "aligned", "ali" }, "Begin environment (aligned)", FORMAT_ENV, function()
        return { node.txt("aligned"), node.ins(1), node.txt("aligned") }
    end)
)

-- Create text autosnippets
for trig, spec in pairs(txt_autosnippets) do
    vim.list_extend(M, { autosnippet({ trig = trig, wordTrig = false, name = spec[2], dscr = "" }, node.txt(spec[1])) })
end

for trig, spec in pairs(postfix_autosnippets) do
    vim.list_extend(M, {
        postfix(
            { trig = trig, name = spec[2], dscr = "", snippetType = "autosnippet", priority = 800 },
            fmt("\\" .. spec[1] .. "{<>}", { create_fn_node(get_capture, { "POSTFIX_MATCH" }) })
        ),
    })
end

-- Create custom autosnippets
vim.list_extend(M, {
    autosnippet(
        { trig = "set", name = "Set", dscr = "Create a set" },
        fmt("\\{<>\\}", { node.ins(1) }),
        COMMAND_BEGIN_CONDITION
    ),
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
    autosnippet({ trig = "ss", wordTrig = false, name = "Subscript", dscr = "" }, fmt("_{<>}", { node.ins(1) })),
    autosnippet({ trig = "SS", wordTrig = false, name = "Superscript", dscr = "" }, fmt("^{<>}", { node.ins(1) })),
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
