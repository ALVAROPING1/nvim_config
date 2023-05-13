local utils = require("user.utils")

-- Make python debugger use the venv python if it exists even if it's not activated
require("dap").configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = utils.get_python_path(vim.loop.cwd()),
        cwd = vim.loop.cwd(),
    },
}

-- Append paths to the python sources if found
local path = require("plenary.path")
if path:new("src/main/python"):is_dir() then
    vim.env.PYTHONPATH = require("user.utils").concat_nullable_str("src/main/python", vim.env.PYTHONPATH, ":")
end
