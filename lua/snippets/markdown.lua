---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("snippets.luasnips")
local parse_snippet = ls.parse_snippet

---------------------------------------------------------------------------------------------------------------------------------
--- Personal imports
---------------------------------------------------------------------------------------------------------------------------------

local data = require("snippets.latex.data")
local utils = require("snippets.latex.utils")

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
---
header-includes: |
    ```{=latex}
    ```
---

# $1

<!-- markdownlint-disable-next-line MD001-->
### Temas

- [Tema 1: $2](#tema-1)
- [Tema 2: $3](#tema-2)
- [Tema 3: $4](#tema-3)
- [Tema 4: $5](#tema-4)
- [Tema 5: $6](#tema-5)
- [Tema 6: $7](#tema-6)
- [Tema 7: $8](#tema-7)
- [Tema 8: $9](#tema-8)
- [Tema 9: $10](#tema-9)

### Exámenes parciales

1) $11
2) $12
3) $13

## Tema 1


        ]]
    ),
}
local autosnippets = {
    parse_snippet({ trig = "tm", name = "Inline math" }, "\\$$1\\$"),
    parse_snippet({ trig = "dm", name = "Display math" }, "\\$\\$$1\\$\\$"),
    parse_snippet({ trig = "TODOC", name = "TODO: completar esto" }, "<!--TODO: Completar esto-->"),
    parse_snippet({ trig = "TODOD", name = "TODO: diapositivas" }, "<!--TODO: diapositivas[$1:$2]-->"),
    utils.environment_snippet(data.envs.generic, data.envs.text, true),
}

return snippets, autosnippets
