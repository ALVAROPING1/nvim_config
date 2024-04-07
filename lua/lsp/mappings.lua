-- LSP mapping settings
return {
    n = {
        ["gh"] = {
            function()
                vim.lsp.buf.hover()
            end,
            desc = "Hover symbol details",
        },
        ["K"] = false,
        ["<leader>lr"] = false,
    },
}
