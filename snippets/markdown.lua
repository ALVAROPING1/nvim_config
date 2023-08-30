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

-- Create custom autosnippets
vim.list_extend(M, {
    autosnippet(
        { trig = "tm", name = "Inline math", dscr = "Inline math" },
        fmt("$<>$<><>", {
            node.ins(1),
            node.fn(function(argnode_text)
                return argnode_text[1][1]:sub(1, 1):match("[,%.%?%- ]") and "" or " "
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
        node.txt({ "---", "header-includes: |", "    ```{=latex}", "    ```", "---", "", "" }),
        { condition = file_beginning, show_condition = file_beginning }
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
