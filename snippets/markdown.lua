---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("user.snippets.luasnips")
local snippet = ls.snippet
local autosnippet = ls.autosnippet
local node = ls.node
local extras = ls.extras
local fmt = ls.fmt

---------------------------------------------------------------------------------------------------------------------------------
--- Personal imports
---------------------------------------------------------------------------------------------------------------------------------

local data = require("user.snippets.latex.data")
local FORMAT_ENV = data.envs.FORMAT
local envs = data.envs.text

local utils = require("user.snippets.utils")
local create_text_nodes = utils.create_text_nodes
local create_snippet = utils.create_snippet

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

local M = {}

local function file_beginning()
    return vim.api.nvim_win_get_cursor(0)[1] == 1
end

local ins_nodes = {}
for i = 1, 13 do
    table.insert(ins_nodes, node.ins(i))
end

-- Create custom autosnippets
vim.list_extend(M, {
    autosnippet(
        { trig = "tm", name = "Inline math", dscr = "Inline math" },
        fmt("$<>$<><>", {
            node.ins(1),
            node.fn(function(argnode_text)
                local next_char = argnode_text[1][1]:sub(1, 1)
                return (next_char == "" or next_char:match("[^%w]")) and "" or " "
            end, 2),
            node.ins(2),
        })
    ),
    autosnippet(
        { trig = "(.?)dm", regTrig = true, wordTrig = false, name = "Display math", dscr = "Display math" },
        fmt("\n$$<>$$", { node.ins(1) }, { trim_empty = false }),
        {
            condition = function(_, _, captures)
                return captures[1] == " " or captures[1] == ""
            end,
        }
    ),
    snippet(
        { trig = "template", name = "Pandoc Header Template" },
        fmt(
            [[---
header-includes: |
    ```{=latex}
    ```
---

# <>

<<!-- markdownlint-disable-next-line MD001-->>
### Temas

- [Tema 1: <>](#tema-1)
- [Tema 2: <>](#tema-2)
- [Tema 3: <>](#tema-3)
- [Tema 4: <>](#tema-4)
- [Tema 5: <>](#tema-5)
- [Tema 6: <>](#tema-6)
- [Tema 7: <>](#tema-7)
- [Tema 8: <>](#tema-8)
- [Tema 9: <>](#tema-9)

### Exámenes parciales

1) <>
2) <>
3) <>

## Tema 1


]],
            ins_nodes,
            { condition = file_beginning, show_condition = file_beginning }
        )
    ),
})

-- Create environment snippets
vim.list_extend(
    M,
    create_snippet({ "begin", "Begin environment (generic)", "beg" }, FORMAT_ENV, function()
        return { node.choice(1, create_text_nodes(envs)), node.ins(2), extras.dup(1) }
    end)
)

return M
