-- Config for the clangd (C/C++) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.clangd
return {
    cmd = { "clangd", "--query-driver=/usr/bin/c++", "--clang-tidy" },
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
    on_new_config = function(new_config, _)
        require("cmake-tools").clangd_on_new_config(new_config)
    end,
}
