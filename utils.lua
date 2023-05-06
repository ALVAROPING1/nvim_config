local M = {}

function M.get_python_path(workspace)
    local path = require("lspconfig/util").path
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({ "*", ".*" }) do
        local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
        if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
        end
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

--- Concatenates 2 given strings with the given separator while checking if either is nil.
--- If one of them is nil, returns the other string as is
---@param str1? string
---@param str2? string
---@param sep string
---@return string?
function M.concat_nullable_str(str1, str2, sep)
    if str1 == nil then
        return str2
    end
    if str2 == nil then
        return str1
    end
    return str1 .. sep .. str2
end

return M
