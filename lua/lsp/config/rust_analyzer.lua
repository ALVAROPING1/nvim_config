-- Config for the rust_analyzer (rust) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.rust_analyzer
return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--", "-W", "clippy::pedantic", "-W", "clippy::nursery", "-W", "clippy::unwrap_used" },
            },
            assist = {
                importPrefix = "self",
            },
            completion = {
                postfix = {
                    enable = true,
                },
            },
        },
    },
}
