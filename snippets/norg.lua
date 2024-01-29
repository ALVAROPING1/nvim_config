---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("user.snippets.luasnips")
local parse_snippet = ls.parse_snippet

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

local function first_line()
    return vim.api.nvim_win_get_cursor(0)[1] == 1
end

-- Create custom autosnippets
local snippets = {
    parse_snippet(
        {
            trig = "template",
            name = "Pandoc Header Template",
            desc = "",
            condition = first_line,
            show_condition = first_line,
        },
        [[
@document.meta
version: 1.1.1
header-includes: [
]
@end

* $1
*** Temas
    - {** Tema 1}[Tema 1: $2]
    - {** Tema 2}[Tema 2: $3]
    - {** Tema 3}[Tema 3: $4]
    - {** Tema 4}[Tema 4: $5]
    - {** Tema 5}[Tema 5: $6]
    - {** Tema 6}[Tema 6: $7]
    - {** Tema 7}[Tema 7: $8]
    - {** Tema 8}[Tema 8: $9]
    - {** Tema 9}[Tema 9: $10]

*** Exámenes parciales
    ~ $11
    ~ $12
    ~ $13

** Tema 1
   - $0
        ]],
        { dedent = false }
    ),
    parse_snippet({ trig = "embed", name = "Embed", desc = "embed block" }, "@embed ${1:lang}\n$2\n@end"),
    parse_snippet({ trig = "latex", name = "Embed latex", desc = "latex block" }, "@embed latex\n$1\n@end"),
}
local autosnippets = {
    parse_snippet({ trig = "tm", name = "Inline math (rigid)" }, "\\$|$1|\\$"),
    parse_snippet({ trig = "ttm", name = "Inline math (simple)" }, "\\$$1\\$"),
    parse_snippet({ trig = "dm", name = "Display math" }, "@math\n$1\n@end"),
    parse_snippet({ trig = "TODOC", name = "TODO: completar esto" }, "%| TODO: Completar esto |%"),
    parse_snippet({ trig = "TODOD", name = "TODO: diapositivas" }, "%| TODO: diapositivas\\[$1:$2\\] |%"),
}

return snippets, autosnippets
