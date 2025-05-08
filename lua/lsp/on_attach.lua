-- A custom `on_attach` function to be run after the default `on_attach` function
-- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
---@param client vim.lsp.Client
---@param buf integer
return function(client, buf)
    require("lsp-format").on_attach(client, buf)
end
