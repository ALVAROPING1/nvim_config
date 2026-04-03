-- Config for the typos (code spelling) language server
---@diagnostic disable: missing-fields
---@type vim.lsp.Config
return {
    init_options = { diagnosticSeverity = "Warning" },
    -- Create custom startup autocommand
    root_dir = function(bufnr, on_dir)
        if
            not vim.list_contains({ "markdown", "norg", "tex", "typst" }, vim.bo[bufnr].ft)
            and vim.bo[bufnr].buftype == ""
            and vim.api.nvim_buf_get_name(bufnr) ~= ""
        then
            on_dir(vim.fn.getcwd())
        end
    end
}
