-- Customize None-ls sources

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
        -- opts variable is the default configuration table for the setup function call
        local null_ls = require("null-ls")

        opts.border = "rounded"

        -- Check supported formatters and linters
        -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

        -- Only insert new sources, do not replace the existing ones
        -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
        opts.sources = require("astrocore").list_insert_unique(opts.sources, {
            -- Set a formatter
            -- null_ls.builtins.formatting.stylua,
            -- null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.prettierd.with({
                extra_args = { "--use-tabs", "--tab-width", "4" },
            }),
            null_ls.builtins.formatting.clang_format.with({
                extra_args = {
                    require("plenary.path"):new(".clang-format"):is_file() and "--style=file"
                    or
                    "--style={BasedOnStyle: LLVM, AlignArrayOfStructures: Right, BreakBeforeBraces: Attach, IndentWidth: 4, AllowShortFunctionsOnASingleLine: Empty, PointerAlignment: Left, SpaceAfterCStyleCast: true, BinPackArguments: false, BinPackParameters: false, AllowShortBlocksOnASingleLine: Always, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}",
                },
            }),
        })
    end,
}
