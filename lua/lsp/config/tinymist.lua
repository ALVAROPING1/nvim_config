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
        local function pin_root(root)
            client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { root },
            }, { bufnr = bufnr })
        end

        vim.keymap.set("n", "<LocalLeader>p", function()
            pin_root(vim.api.nvim_buf_get_name(0))
        end, { desc = "Tinymist Pin" })

        local root = "report.typ"
        if require("plenary.path"):new(root):is_file() then
            pin_root(vim.fs.abspath(root))
        end
    end,
}
