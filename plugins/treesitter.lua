return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "LiadOz/nvim-dap-repl-highlights", config = true },
    opts = {
        auto_install = true,
        ensure_installed = { "comment", "jsonc", "dap_repl" },
    },
}
