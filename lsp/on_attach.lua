return function(client)
    require("lsp-format").on_attach(client)
    local namespace = vim.lsp.diagnostic.get_namespace(client.id)
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        callback = function(args)
            if vim.tbl_contains(vim.g.lsp_lines, vim.bo.ft) then
                return
            end

            vim.diagnostic.handlers.virtual_text.hide(namespace, args.buf)

            local diagnostics = require("user.utils").other_line_diagnostic(namespace, args.buf)
            table.sort(diagnostics, function(a, b)
                return a.severity > b.severity
            end)
            pcall(vim.diagnostic.handlers.virtual_text.show, namespace, args.buf, diagnostics, nil)
        end,
    })
end
