-- Config for the tinymist (typst) language server
---@diagnostic disable: missing-fields
---@type lspconfig
return {
    ---@type lspconfig.settings.tinymist
    settings = {
        tinymist = {
            formatterIndentSize = 4,
            formatterPrintWidth = 80,
            formatterProseWrap = true,
            lint = { enabled = true },
        },
    },
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>p", function()
            client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { vim.api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr })
        end, { desc = "Tinymist Pin", noremap = true })
    end,
}
