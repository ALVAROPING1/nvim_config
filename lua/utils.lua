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
---@param obj any Message to be logged
function M.log(obj)
    local log_file = io.open("log.log", "a")
    if log_file ~= nil then
        io.output(log_file)
        io.write(vim.inspect(obj) .. "\n")
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

--- Moves a value of a table to a different key
---@param tbl table
---@param dest any
---@param src any
function M.tbl_move(tbl, dest, src)
    tbl[dest] = tbl[src]
    tbl[src] = nil
end

--- Creates a buffer-local mapping that runs the current buffer with the clipboard as `STDIN` using the specified program
---@param program string Program to run the buffer with. The buffer file name will be appended as the last argument
function M.run_file_mapping(program)
    local function cb()
        require("astrocore").toggle_term_cmd({
            cmd = "xclip -o -selection clipboard | " .. program .. ' "' .. vim.api.nvim_buf_get_name(0) .. '"',
            direction = "float",
            close_on_exit = false,
        })
    end
    require("which-key").add({ { "<LocalLeader>r", cb, desc = "Run file with clipboard" } }, { buffer = 0 })
end

return M
