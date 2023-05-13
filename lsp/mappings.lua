-- LSP mapping settings
return {
    n = {
        ["gk"] = {
            function()
                vim.lsp.buf.hover()
            end,
            desc = "Hover symbol details",
        },
        ["K"] = false,
    },
}
