-- Customize Mason plugins

---@type LazySpec
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
            opts.ensure_installed = require("astrocore").list_insert_unique(
                opts.ensure_installed,
                { "clangd", "basedpyright", "vhdl_ls", "typos_lsp" }
            )
        end,
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    {
        "jay-babu/mason-null-ls.nvim",
        -- overrides `require("mason-null-ls").setup(...)`
        opts = function(_, opts)
            -- add more things to the ensure_installed table protecting against community packs modifying it
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
                -- "prettier",
                -- "cspell",
                "markdownlint",
                "clang-format",
            })
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
