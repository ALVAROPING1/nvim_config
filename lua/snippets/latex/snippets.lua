---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("snippets.luasnips")
local snippet = ls.snippet
local parse_snippet = ls.parse_snippet
local multi_snippet = ls.multi_snippet
local node = ls.node
local fmt = ls.fmt
local disabled = ls.conds.disabled

---------------------------------------------------------------------------------------------------------------------------------
--- Personal imports
---------------------------------------------------------------------------------------------------------------------------------

local data = require("snippets.latex.data")
local utils = require("snippets.latex.utils")

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

--- Snippet condition checking that the cursor is in a tikzpicture environment
local tikz_cond = utils.in_text * utils.in_environment("tikzpicture")

local snippets = {
    utils.create_snippet(data.int, "\\" .. data.int[1] .. "<>{<> d<>}", {
        node.choice(1, {
            node.txt(""),
            parse_snippet(nil, "_$1^$2"),
        }),
        node.ins(2),
        node.ins(3),
    }),
    utils.create_snippet(
        data.limit,
        "\\" .. data.limit[1] .. "_{<> \\to <>}{<>}",
        parse_snippet(nil, "${1:x}${2:\\infty}$3")
    ),
    -- Create environment snippets
    utils.environment_snippet(data.envs.generic, data.envs.math),
    utils.environment_snippet(data.envs.generic, data.envs.text, true),
    utils.environment_snippet(data.envs.aligned, "aligned"),
    -- Tikzpicture snippets
    snippet(
        { trig = "node", name = "Tikz node", condition = tikz_cond, show_condition = tikz_cond },
        fmt("\\node[<>] (<>) <> {<>};", {
            node.ins(1),
            node.ins(2, "id"),
            node.choice(3, {
                parse_snippet(nil, "[${1:direction} = of ${2:id}]"),
                parse_snippet(nil, "at (${1:x}, ${2:y})"),
            }),
            node.ins(4, "text"),
        })
    ),
    snippet(
        { trig = "draw", name = "Tikz draw", condition = tikz_cond[1], show_condition = tikz_cond[2] },
        fmt("\\draw[<>] (<>) <> (<>);", {
            node.ins(1),
            node.ins(2, "start"),
            node.choice(3, {
                node.txt("--"),
                node.txt("-|"),
                node.txt("|-"),
                parse_snippet(nil, "edge[$1] node[$2] {${3:text}\\}"),
            }),
            node.ins(4, "end"),
        })
    ),
}

---@param context table
---@return table
local function ctx(context)
    return vim.tbl_extend("force", { condition = utils.in_math, show_condition = disabled }, context)
end

local autosnippets = {
    -- Set
    parse_snippet({ trig = "set", name = "Set", dscr = "Create a set", condition = utils.in_math }, "\\{$1\\\\}"),
    -- Toggle parenthesis
    snippet(
        ctx({ trig = "()", name = "Parenthesis", dscr = "Toggle parenthesis size" }),
        node.choice(1, { fmt("(<>)", node.restore(1, "x")), fmt("\\left( <> \\right)", node.restore(1, "x")) })
    ),
    -- Auto subscripts
    multi_snippet({
        common = ctx({ name = "Auto subscript" }),
        { trig = "(%a'*)(%d)",                     trigEngine = "pattern" },
        { trig = "\\([xyzt]'*\\)\\([ijknm]\\)\\2", trigEngine = "vim" },
    }, fmt("<>_<>", { node.capture(1), node.capture(2) })),
    snippet(
        ctx({ trig = "(%a'*)_(%d%d)", regTrig = true, name = "Auto subscript" }),
        fmt("<>_{<>}", { node.capture(1), node.capture(2) })
    ),
    -- Automatic fractions
    snippet(
        ctx({ trig = "(%b())/", regTrig = true, name = "Automatic fraction" }),
        fmt("\\frac{<>}{<>}", { node.capture(1, { 1, 1 }), node.ins(1) })
    ),
    snippet(
        ctx({ trig = "([%w_%^\\]+)/", regTrig = true, name = "Automatic fraction" }),
        fmt("\\frac{<>}{<>}", { node.capture(1), node.ins(1) })
    ),
    snippet(
        ctx({ trig = "//", name = "Fraction" }),
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
}

-- Create snippets based on the commands in cmds
for num_params, command_groups in ipairs(data.cmds) do
    local params = string.rep("{<>}", num_params - 1)
    for _, command_group in pairs(command_groups) do
        utils.add_snippet_group(snippets, command_group, params, function()
            return parse_snippet(nil, "$1$2$3")
        end)
    end
end

-- Create function snippets
utils.add_snippet_group(snippets, data.functions, "(<>)", function()
    return { node.ins(1) }
end)

-- Create snippets for operators with limits
utils.add_snippet_group(snippets, data.limit_operators, "<>{<>}", function()
    return {
        node.choice(1, {
            parse_snippet(nil, "_${1:i}"),
            parse_snippet(nil, "_{${1:i} = ${2:0}}"),
            parse_snippet(nil, "_{${1:i} = ${2:0}}^${3:\\infty}"),
        }),
        node.choice(2, { node.restore(1, "x"), fmt("\\left( <> \\right)", { node.restore(1, "x") }) }),
    }
end)

-- Create raw postfix autosnippets
for trig, spec in pairs(data.raw_postfix_autosnippets) do
    table.insert(
        autosnippets,
        parse_snippet({ trig = trig, wordTrig = false, name = spec[2], condition = utils.in_math }, spec[1])
    )
end

-- Create postfix autosnippets
for trig, spec in pairs(data.postfix_autosnippets) do
    table.insert(
        autosnippets,
        ls.extras.postfix(
            { trig = trig, name = spec[2], priority = 800, condition = utils.in_math, show_condition = disabled },
            fmt("\\" .. spec[1] .. "{<>}", { node.capture("POSTFIX_MATCH") })
        )
    )
end

return snippets, autosnippets
