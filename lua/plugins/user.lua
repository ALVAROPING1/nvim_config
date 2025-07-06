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
        "jbyuki/nabla.nvim",
        keys = {
            { "<leader>M", "<cmd>lua require('nabla').popup({border='rounded'})<cr>", desc = "Open math render popup" },
            {
                "<leader><leader>M",
                "<cmd>lua require('nabla').toggle_virt({autogen=true})<cr>",
                desc = "Render math with virtual lines",
            },
        },
    },
    {
        "lukas-reineke/lsp-format.nvim",
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
    { "3rd/image.nvim",          config = true },
    {
        "barreiroleo/ltex_extra.nvim",
        branch = "dev",
        event = "VeryLazy",
        opts = { load_langs = { "es", "en-US" } },
    },
    {
        "cappyzawa/trim.nvim",
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
