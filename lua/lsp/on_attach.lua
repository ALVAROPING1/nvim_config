-- A custom `on_attach` function to be run after the default `on_attach` function
-- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
---@param client lsp.Client
---@param _ integer
return function(client, _)
    require("lsp-format").on_attach(client)
end
