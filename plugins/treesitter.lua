local utils = require("astronvim.utils")
return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        opts.auto_install = false -- Requires tree-sitter-cli from cargo
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "gitignore", "latex", "c" })
    end,
}
