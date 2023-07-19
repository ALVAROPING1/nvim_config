return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        auto_install = false, -- Requires tree-sitter-cli from cargo
        ensure_installed = { "gitignore", "latex" },
    },
}
