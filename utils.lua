local M = {}

-- --- Run a code action on the previous diagnostic for the given server
-- ---@param name string Name of the server providing the diagnostic
-- ---@param action_kinds string[]? List of action kinds requested
-- ---@param apply boolean Apply code action automatically if there is a single action left after filtering
-- function M.fix_previous_diagnostic(name, action_kinds, apply)
--     local client = vim.lsp.get_active_clients({ name = name, bufnr = 0 })[1]
--     local attached = client ~= nil
--     if attached then
--         local namespace = vim.lsp.diagnostic.get_namespace(client.id)
--         local current_column = vim.api.nvim_win_get_cursor(0)[2]
--         --- vim.fn.getline(".") can be used to get the current line, in which case it returns a string
--         ---@diagnostic disable-next-line: param-type-mismatch
--         local current_line_length = string.len(vim.fn.getline("."))
--         vim.diagnostic.goto_prev({ namespace = namespace, float = false })
--         vim.lsp.buf.code_action({ context = { only = action_kinds }, apply = apply })
--         vim.cmd("normal ``") -- Return to the original position of the cursor
--         -- Fix cursor returning to 1 character earlier than it started if it was at a line end in insert mode
--         if current_column ~= 0 and current_column >= current_line_length then
--             vim.api.nvim_input("<Esc>la")
--         end
--     end
-- end

--- Logs a message to a file
---@param file string Path to the file to write in
---@param message any Message to be logged
function M.log(file, message)
    local log_file = io.open(file, "a")
    if log_file ~= nil then
        io.output(log_file)
        io.write(message .. "\n")
        io.close(log_file)
    end
end

--- Creates a mapping that saves the view, executes another mapping, and restores the view
---@param mapping string Mapping to execute
---@return string
function M.restore_view(mapping)
    -- See: `:h restore-position`
    return "msHmt" .. mapping .. "'tzt`s"
end

return M
