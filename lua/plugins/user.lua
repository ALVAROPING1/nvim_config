-- You can also add or configure plugins by creating files in this `plugins/` folder

---@type LazySpec
return {
    -- You can also add new plugins here as well:
    -- Add plugins, the lazy syntax
    -- "andweeb/presence.nvim",
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },
    { "Mofiqul/vscode.nvim",     opts = { terminal_colors = false } },
    {
        -- TODO: switch back to main repo once #97 is merged (fixes deprecated lsp client methods)
        -- "lukas-reineke/lsp-format.nvim",
        "jfly/lsp-format.nvim",
        branch = "issue-95",
        event = "LspAttach",
        opts = {
            lua = { order = { "null-ls", "lua_ls" } },
            markdown = { exclude = { "null-ls" } },
            c = { exclude = { "clangd" } },
            cpp = { exclude = { "clangd" } },
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = { hint_enable = false, noice = true },
    },
    {
        "axkirillov/hbac.nvim",
        event = "User AstroFile",
        opts = {
            threshold = 5,
            close_command = function(...)
                require("astrocore.buffer").close(...)
            end,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        -- Fix autosnippets ending in ">" not being triggered due to nvim-ts-autotag
        -- SEE: https://github.com/windwp/nvim-ts-autotag/issues/102
        -- SEE: https://github.com/L3MON4D3/LuaSnip/issues/865
        enabled = false,
    },
    { "Bekaboo/deadcolumn.nvim", event = "User AstroFile",          opts = { warning = { hlgroup = { "Error", "fg" } } } },
    {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        event = "VeryLazy",
        opts = { load_langs = { "es", "en-US" } },
    },
    {
        "cappyzawa/trim.nvim",
        cmd = "Trim",
        keys = { { "<Leader><Leader>w", "<Cmd>Trim<CR>", desc = "Trim whitespace" } },
        opts = {
            ft_blocklist = { "markdown" },
            trim_last_line = false,
            trim_first_line = false,
            trim_on_write = false,
            notifications = false,
        },
    },
}
