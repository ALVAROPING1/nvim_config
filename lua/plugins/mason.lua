-- Customize Mason plugins

-- use mason-tool-installer for automatically installing Mason packages
---@type LazySpec
return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = function(_, opts)
        -- Make sure to use the names found in `:Mason`
        -- add more things to the ensure_installed table protecting against community packs modifying it
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
            -- install language servers
            "clangd",
            "rust_hdl",
            "typos-lsp",
            "vtsls",
            "eslint-lsp",
            "ltex-ls",

            -- install formatters
            "stylua",
            "markdownlint",
            "clang-format",

            -- install debuggers
            -- "debugpy",

            -- install any other package
            -- "tree-sitter-cli",
        })
    end,
}
