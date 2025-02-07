local M = {}

--- Gets the python executable to use
--- Priority order:
--- 1. Currently active venv
--- 2. Executable in the .venv folder in the current workspace root
--- 3. System python3 or python, or local python
---@param workspace string? Current workspace root
---@return string Executable Path of the python executable
function M.get_path(workspace)
    local path = require("lspconfig/util").path
    -- Use activated virtualenv
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv in workspace directory
    for _, pattern in ipairs({ "*", ".*" }) do
        local match = vim.fn.glob(path.join(workspace or ".", pattern, "pyvenv.cfg"))
        if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
        end
    end

    -- Fallback to system Python
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

--- Concatenates 2 given strings with the given separator while checking if either is nil.
--- If one of them is nil, returns the other string as is
---@param str1? string First string
---@param str2? string Second string
---@param sep string String separator
---@return string|nil Result Concatenated string
local function concat_nullable_str(str1, str2, sep)
    return str1 == nil and str2 or str2 == nil and str1 or str1 .. sep .. str2
end

--- Filters the paths to those found, appends them to the python sources and returns them
---@param paths string[] List of paths to add
---@return string[] # List of found paths
function M.get_sources(paths)
    return vim.tbl_filter(function(path)
        local check = require("plenary.path"):new(path):is_dir()
        if check then
            vim.env.PYTHONPATH = concat_nullable_str(path, vim.env.PYTHONPATH, ":")
        end
        return check
    end, paths)
end

return M
