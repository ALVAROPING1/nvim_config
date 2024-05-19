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
    { "Mofiqul/vscode.nvim", opts = { terminal_colors = false } },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User AstroFile",
        config = true,
    },
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
        opts = {
            hint_enable = false,
            noice = true,
        },
    },
    {
        "axkirillov/hbac.nvim",
        event = "User AstroFile",
        opts = {
            threshold = 5,
            close_command = require("astronvim.utils.buffer").close,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        -- Fix autosnippets ending in ">" not being triggered due to nvim-ts-autotag
        -- SEE: https://github.com/windwp/nvim-ts-autotag/issues/102
        -- SEE: https://github.com/L3MON4D3/LuaSnip/issues/865
        enabled = false,
    },
    {
        "Bekaboo/deadcolumn.nvim",
        event = "User AstroFile",
        opts = { blending = { threshold = 0.5 }, warning = { hlgroup = { "Error", "fg" } } },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "natecraddock/telescope-zf-native.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
        },
        opts = function()
            require("telescope").load_extension("zf-native")
        end,
    },
}
