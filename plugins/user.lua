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
    "Mofiqul/vscode.nvim",
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User AstroFile",
    },
    {
        "ggandor/leap.nvim",
        event = "User AstroFile",
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    "LiadOz/nvim-dap-repl-highlights",
    "jbyuki/nabla.nvim",
    {
        "lukas-reineke/lsp-format.nvim",
        event = "LspAttach",
        opts = {
            lua = { order = { "null-ls", "lua_ls" } },
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
        "barreiroleo/ltex-extra.nvim",
        ft = { "gitcommit", "markdown", "org", "plaintex", "tex", "pandoc" },
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {
            server_opts = require("user.lsp.config.ltex"),
            path = require("plenary.path"):new(".ltex"):is_dir() and ".ltex"
                or vim.env.XDG_CONFIG_HOME .. "/nvim/lua/user/spell",
            load_langs = { "es", "en-US" },
        },
    },
    {
        "axkirillov/hbac.nvim",
        event = "VeryLazy",
        opts = {
            threshold = 5,
            close_command = require("astronvim.utils.buffer").close,
        },
    },
}
