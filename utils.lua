local M = {}

--- Gets the python executable to use
--- Priority order:
--- 1. Currently active venv
--- 2. Executable in the .venv folder in the current workspace root
--- 3. System python3 or python, or local python
---@param workspace string? Current workspace root
---@return string Executable Path of the python executable
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
---@param str1? string First string
---@param str2? string Second string
---@param sep string String separator
---@return string|nil Result Concatenated string
function M.concat_nullable_str(str1, str2, sep)
    if str1 == nil then
        return str2
    end
    if str2 == nil then
        return str1
    end
    return str1 .. sep .. str2
end

--- Run a code action on the previous diagnostic for the given server
---@param name string Name of the server providing the diagnostic
---@param action_kinds string[]? List of action kinds requested
---@param apply boolean Apply code action automatically if there is a single action left after filtering
function M.fix_previous_diagnostic(name, action_kinds, apply)
    local client = vim.lsp.get_active_clients({ name = name, bufnr = 0 })[1]
    local attached = client ~= nil
    if attached then
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        local current_column = vim.api.nvim_win_get_cursor(0)[2]
        --- vim.fn.getline(".") can be used to get the current line, in which case it returns a string
        ---@diagnostic disable-next-line: param-type-mismatch
        local current_line_length = string.len(vim.fn.getline("."))
        vim.diagnostic.goto_prev({ namespace = namespace, float = false })
        vim.lsp.buf.code_action({ context = { only = action_kinds }, apply = apply })
        vim.cmd("normal ``") -- Return to the original position of the cursor
        -- Fix cursor returning to 1 character earlier than it started if it was at a line end in insert mode
        if current_column ~= 0 and current_column >= current_line_length then
            vim.api.nvim_input("<Esc>la")
        end
    end
end

return M
