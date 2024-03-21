local utils = require("astronvim.utils")
-- customize mason plugins
return {
    -- use mason-lspconfig to configure LSP installations
    {
        "williamboman/mason-lspconfig.nvim",
        -- overrides `require("mason-lspconfig").setup(...)`
        opts = function(_, opts)
            -- Disable upstream's `pyright` since it's replaced with `basedpyright`
            opts.ensure_installed = vim.tbl_filter(function(x)
                return x ~= "pyright"
            end, opts.ensure_installed)
            opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "clangd", "basedpyright" })
        end,
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        -- overrides `require("mason-null-ls").setup(...)`
        opts = function(_, opts)
            opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, {
                -- "prettier",
                -- "cspell",
                "markdownlint",
                "clang-format",
            })
            opts.ensure_installed = vim.tbl_filter(function(v)
                return v ~= "luacheck"
            end, opts.ensure_installed)
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        -- overrides `require("mason-nvim-dap").setup(...)`
        -- opts = {
        --     ensure_installed = {},
        -- },
    },
}
