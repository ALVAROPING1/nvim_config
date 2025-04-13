-- Customize Treesitter

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        opts.auto_install = true -- Requires tree-sitter-cli from cargo
        -- Add more things to the ensure_installed table protecting against community packs modifying it
        opts.ensure_installed = require("astrocore").list_insert_unique(
            opts.ensure_installed,
            { "gitignore", "latex", "c", "cpp", "html", "vhdl", "javascript", "jsdoc", "bibtex", "norg", "norg_meta" }
        )
    end,
}
