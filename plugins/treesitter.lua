return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "LiadOz/nvim-dap-repl-highlights", config = true },
    opts = {
        auto_install = false, -- Requires tree-sitter-cli from cargo
        ensure_installed = { "dap_repl", "gitignore", "latex" },
    },
}
