-- Config for the pyright (python) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.pyright
return {
    before_init = function(_, config)
        local utils = require("user.python_utils")
        config.settings.python = {
            analysis = { extraPaths = utils.get_sources({ "src/main/python", "." }) },
            pythonPath = utils.get_path(config.root_dir),
        }
    end,
}
