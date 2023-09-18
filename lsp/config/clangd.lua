-- Config for the clangd (C/C++) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.clangd
return {
    cmd = { "clangd", "--query-driver=/usr/bin/c++" },
    capabilities = {
        offsetEncoding = "utf-8",
    },
    settings = {
        clangd = {},
    },
    on_attach = function()
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
}
