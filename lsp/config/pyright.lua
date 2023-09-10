-- Config for the pyright (python) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.pyright
return {
    before_init = function(_, config)
        config.settings.python = {
            analysis = { extraPaths = require("user.utils").python.get_sources({ "src/main/python" }) },
            pythonPath = require("user.utils").python.get_path(config.root_dir),
        }
    end,
}
