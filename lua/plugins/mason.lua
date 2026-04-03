-- Customize Mason plugins

-- use mason-tool-installer for automatically installing Mason packages
---@type LazySpec
return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
        -- Make sure to use the names found in `:Mason`
        ensure_installed = {
            -- install language servers
            "clangd",
            "rust_hdl",
            "typos-lsp",
            "vtsls",
            "eslint-lsp",
            "ltex-ls-plus",

            -- install formatters
            "stylua",
            "markdownlint",
            "clang-format",

            -- install debuggers
            -- "debugpy",

            -- install any other package
            -- "tree-sitter-cli",
        },
    },
}
