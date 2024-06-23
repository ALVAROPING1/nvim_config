-- Config for the clangd (C/C++) language server
---@diagnostic disable: missing-fields
---@type lspconfig
return {
    cmd = { "clangd", "--query-driver=/usr/bin/c++", "--clang-tidy" },
    -- capabilities = {
    --     offsetEncoding = "utf-8",
    -- },
    ---@type lspconfig.settings.clangd
    settings = { clangd = {} },
    on_new_config = function(new_config, _)
        require("cmake-tools").clangd_on_new_config(new_config)
    end,
    -- This is needed to prevent clangd from auto-expanding function completions sometimes when selecting them on cmp?
    -- TODO: check if it has any sideeffects
    capabilities = vim.lsp.protocol.make_client_capabilities(),
}
