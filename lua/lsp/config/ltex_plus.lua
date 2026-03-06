-- Config for the rust_analyzer (rust) language server

local words = {}
for i = 1, 1000 do
    words[i] = "Dummy" .. i - 1
end
vim.list_extend(words, { "Dummies" })

---@diagnostic disable: missing-fields
---@type lspconfig
return {
    filetypes = { "tex", "latex", "typst" },
    ---@type lspconfig.settings.ltex
    settings = {
        ltex = {
            language = "es",
            additionalRules = { motherTongue = "es" },
            completionEnabled = true,
            dictionary = { es = words },
            latex = {
                commands = {
                    ["\\label{}"] = "ignore",
                    ["\\documentclass[]{}"] = "ignore",
                    ["\\parencite{}"] = "dummy",
                    ["\\gls{}"] = "dummy",
                    ["\\Gls{}"] = "dummy",
                    ["\\glspl{}"] = "pluralDummy",
                    ["\\Glspl{}"] = "pluralDummy",
                    ["\\glsdisp{}"] = "ignore",
                    ["\\glsdisponly{}"] = "ignore",
                    ["\\advisors{}"] = "ignore",
                    ["\\includefrom{}{}"] = "ignore",
                    ["\\includesvg[]{}"] = "ignore",
                    ["\\drawiosvgfigure[]{}"] = "ignore",
                    ["\\ref{}"] = "dummy",
                    ["\\nameref{}"] = "dummy",
                    ["\\chapterref{}"] = "dummy",
                    ["\\sectionref{}"] = "dummy",
                    ["\\subsectionref{}"] = "dummy",
                    ["\\tableref{}"] = "dummy",
                    ["\\figureref{}"] = "dummy",
                    ["\\sreqref{}"] = "dummy",
                    ["\\ureqref{}"] = "dummy",
                    ["\\ProvidesPackage{}[]"] = "ignore",
                    ["\\newglossaryentry{}{}"] = "ignore",
                    ["\\newglossaryentrywithacronym{}{}"] = "ignore",
                    ["\\newacronym{}{}{}"] = "ignore",
                    ["\\traceabilityTable{}{}{}"] = "ignore",
                },
                environments = {
                    grammar = "ignore",
                },
            },
        },
    },
}
