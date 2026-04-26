-- Config for the pyright (python) language server
---@diagnostic disable: missing-fields
---@type vim.lsp.Config
return {
    before_init = function(_, config)
        local utils = require("python_utils")
        --stylua: ignore
        config.settings.python = {
            analysis = { extraPaths = utils.get_sources({ "src/main/python", "." }) },
            pythonPath = utils.get_path(config.root_dir),
        }
    end,
    ---@module "lspconfig"
    ---@type lspconfig.settings.basedpyright
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                    strictListInference = true,
                    strictDictionaryInference = true,
                    strictSetInference = true,
                    deprecateTypingAliases = true,
                    reportGeneralTypeIssues = "error",
                    reportDuplicateImport = "information",
                    reportMissingParameterType = "warning",
                    reportMissingTypeArgument = "error",
                    reportOptionalMemberAccess = "error",
                    reportOptionalSubscript = "error",
                    reportPrivateImportUsage = "error",
                    reportPrivateUsage = "error",
                    reportUnnecessaryCast = "information",
                    reportUnnecessaryComparison = "information",
                    reportUnnecessaryContains = "information",
                    reportUnnecessaryIsInstance = "information",
                    reportUnusedImport = "unused",
                    reportUnusedFunction = "unused",
                    reportUnusedVariable = "unused",
                    reportUntypedBaseClass = "error",
                    reportUntypedClassDecorator = "error",
                    reportUntypedFunctionDecorator = "error",
                    reportUntypedNamedTuple = "error",
                    reportImplicitStringConcatenation = "warning",
                    reportUninitializedInstanceVariable = "warning",
                    reportUnnecessaryTypeIgnoreComment = "information",
                },
            },
        },
    },
}
