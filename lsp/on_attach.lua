--- Gets all the diagnostics for the given buffer and namespace except those on the current line
---@param namespace number Namespace
---@param bufnr number Buffer number
---@return Diagnostic[]
local function other_line_diagnostic(namespace, bufnr)
    local diagnostics = vim.diagnostic.get(bufnr, { namespace = namespace })

    local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    return vim.tbl_filter(function(v)
        return current_line < v.lnum or v.end_lnum < current_line
    end, diagnostics)
end

return function(client)
    require("lsp-format").on_attach(client)
    local namespace = vim.lsp.diagnostic.get_namespace(client.id)
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        callback = function(args)
            if vim.tbl_contains(vim.g.lsp_lines, vim.bo.ft) then
                return
            end

            vim.diagnostic.handlers.virtual_text.hide(namespace, args.buf)

            local diagnostics = other_line_diagnostic(namespace, args.buf)
            table.sort(diagnostics, function(a, b)
                return a.severity > b.severity
            end)
            pcall(vim.diagnostic.handlers.virtual_text.show, namespace, args.buf, diagnostics, nil)
        end,
    })
end
