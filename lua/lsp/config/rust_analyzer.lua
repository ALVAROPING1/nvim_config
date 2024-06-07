-- Config for the rust_analyzer (rust) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.rust_analyzer
return {
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
                postfix = {
                    enable = true,
                },
            },
            diagnostics = { styleLints = { enable = true } },
            inlayHints = { closureReturnTypeHints = { enable = "with_block" } },
        },
    },
}
