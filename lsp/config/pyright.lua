-- Config for the pyright (python) language server
return {
    before_init = function(_, config)
        config.settings.python = {
            analysis = { extraPaths = { "src/main/python" } },
            pythonPath = require("user.utils").get_python_path(config.root_dir),
        }
    end,
}
