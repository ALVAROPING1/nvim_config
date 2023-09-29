return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require("null-ls")

        -- Check supported formatters and linters
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        config.sources = {
            -- Set a formatter
            -- null_ls.builtins.formatting.stylua,
            -- null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.prettierd.with({
                extra_args = { "--use-tabs", "--tab-width", "4" },
            }),
            null_ls.builtins.diagnostics.typos.with({ disabled_filetypes = { "markdown" } }),
            null_ls.builtins.formatting.clang_format.with({
                extra_args = {
                    require("plenary.path"):new(".clang-format"):is_file() and "--style=file"
                    or
                    "--style={BasedOnStyle: LLVM, AlignArrayOfStructures: Right, BreakBeforeBraces: Attach, IndentWidth: 4, AllowShortFunctionsOnASingleLine: Empty, PointerAlignment: Left, SpaceAfterCStyleCast: true, BinPackArguments: false, BinPackParameters: false, AllowShortBlocksOnASingleLine: Always, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}",
                },
            }),
        }
        return config -- return final config table
    end,
}
