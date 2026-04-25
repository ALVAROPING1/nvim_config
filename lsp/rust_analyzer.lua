-- Config for the rust_analyzer (rust) language server
---@diagnostic disable: missing-fields
---@type vim.lsp.Config
return {
    ---@module "lspconfig"
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                -- stylua: ignore
                extraArgs = { "--", "-W", "clippy::pedantic", "-W", "clippy::nursery", "-W", "clippy::unwrap_used", "--no-deps" },
            },
            assist = {
                importPrefix = "self",
                emitMustUse = true, -- TODO: check what this does
            },
            completion = {
                postfix = { enable = true },
                callable = { snippets = "none" }, -- "fill_arguments" causes functions to be auto-expanded when selected on cmp
            },
            diagnostics = { styleLints = { enable = true } },
            inlayHints = { closureReturnTypeHints = { enable = "with_block" } },
            lens = { implementations = { enable = false } },
        },
    },
}
