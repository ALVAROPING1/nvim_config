-- Config for the vtsls (JS/TS) language server
---@diagnostic disable: missing-fields
---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.vtsls
    ---@module "lspconfig"
    settings = {
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
        vtsls = { enableMoveToFileCodeAction = true },
    },
}
