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
        config = true,
    },
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
        "axkirillov/hbac.nvim",
        event = "VeryLazy",
        opts = {
            threshold = 5,
            close_command = require("astronvim.utils.buffer").close,
        },
    },
}
