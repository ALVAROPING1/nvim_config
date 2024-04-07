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
        -- ["gl"] = {
        --     function()
        --         vim.diagnostic.open_float()
        --     end,
        --     desc = "Hover diagnostics",
        -- },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
    },
}
