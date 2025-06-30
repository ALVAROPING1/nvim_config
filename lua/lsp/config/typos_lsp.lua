-- Config for the typos (code spelling) language server

-- Create custom startup autocommand
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(opt)
        local nr = opt.buf
        if
            not vim.list_contains({ "markdown", "norg", "tex" }, vim.bo[nr].ft)
            and vim.bo[nr].buftype == ""
            and vim.api.nvim_buf_get_name(nr) ~= ""
        then
            require("lspconfig").typos_lsp.launch()
        end
    end,
})

---@diagnostic disable: missing-fields
---@type lspconfig
return {
    autostart = false,
    init_options = { diagnosticSeverity = "Warning" },
}
