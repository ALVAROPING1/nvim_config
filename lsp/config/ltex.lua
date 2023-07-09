-- Config for the ltex (latex and LanguageTool) language server
---@type lspconfig.options.ltex
return {
    on_attach = function() end,
    settings = {
        ltex = {
            additionalRules = {
                motherTongue = "es",
            },
        },
    },
}
