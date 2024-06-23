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
}
