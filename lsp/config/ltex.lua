-- Config for the ltex (latex and LanguageTool) language server
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
