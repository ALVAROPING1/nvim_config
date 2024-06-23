-- Config for the pyright (python) language server
---@diagnostic disable: missing-fields
---@type lspconfig
return {
    before_init = function(_, config)
        local utils = require("python_utils")
        --stylua: ignore
        config.settings --[[@as lspconfig.settings.pyright]].python = {
            analysis = { extraPaths = utils.get_sources({ "src/main/python", "." }) },
            pythonPath = utils.get_path(config.root_dir),
        }
    end,
}
