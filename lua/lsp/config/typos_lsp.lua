-- Config for the typos (code spelling) language server

-- Create custom startup autocommand
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(opt)
        if not vim.tbl_contains({ "markdown", "norg" }, vim.bo[opt.buf].ft) and vim.bo[opt.buf].buftype ~= "nofile" then
            require("lspconfig").typos_lsp.launch()
        end
    end,
})

return {
    autostart = false,
    init_options = {
        diagnosticSeverity = "Warning",
    },
}
