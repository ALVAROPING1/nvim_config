return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        opts.auto_install = false -- Requires tree-sitter-cli from cargo
        opts.ensure_installed = require("astronvim.utils").list_insert_unique(
            opts.ensure_installed,
            { "gitignore", "latex", "c", "cpp", "html", "vhdl" }
        )
        ---@diagnostic disable-next-line: inject-field Documentation indicates this is how parsers are added
        require("nvim-treesitter.parsers").get_parser_configs().vhdl = {
            install_info = {
                url = "https://github.com/alemuller/tree-sitter-vhdl",
                files = { "src/parser.c" },
                branch = "main",
            },
        }
    end,
}
