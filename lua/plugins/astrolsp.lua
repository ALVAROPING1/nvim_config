-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
        -- Configuration table of features provided by AstroLSP
        features = {
            codelens = true,             -- enable/disable codelens refresh on start
            inlay_hints = true,          -- enable/disable inlay hints on start
            inline_completion = false,   -- enable/disable inline completion capabilities
            linked_editing_range = true, -- enable/disable linked editing range capabilities
            semantic_tokens = true,      -- enable/disable semantic token highlighting
        },
        -- customize lsp formatting options
        formatting = require("lsp.formatting"),
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
            -- "ghdl_ls",
        },
        -- customize language server configuration passed to `vim.lsp.config`
        -- client specific configuration can also go in `lsp/` in your configuration root (see `:h lsp-config`)
        config = {
            -- ["*"] = { capabilities = {} }, -- modify default LSP client settings such as capabilities
        },
        -- customize how language servers are attached
        handlers = {
            -- a function with the key `*` modifies the default handler, functions takes the server name as the parameter
            -- ["*"] = function(server)
            --     -- If you need the LSP options for a server use `vim.lsp.config` table
            --     -- This is useful for cases of setting up language server specific plugins
            --     -- local opts = vim.lsp.config[server]
            --     vim.lsp.enable(server)
            -- end

            -- the key is the server that is being setup with `vim.lsp.config`
            -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
        },
        -- Configure buffer local auto commands to add when attaching a language server
        autocmds = {
            -- first key is the `augroup` to add the auto commands to (:h augroup)
            -- lsp_codelens_refresh = {
            --     -- Optional condition to create/delete auto command group
            --     -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
            --     -- condition will be resolved for each client on each execution and if it ever fails for all clients,
            --     -- the auto commands will be deleted for that buffer
            --     cond = "textDocument/codeLens",
            --     -- cond = function(client, bufnr) return client.name == "lua_ls" end,
            --     -- list of auto commands to set
            --     {
            --         -- events to trigger
            --         event = { "InsertLeave", "BufEnter" },
            --         -- the rest of the autocmd options (:h nvim_create_autocmd)
            --         desc = "Refresh codelens (buffer)",
            --         callback = function(args)
            --             if require("astrolsp").config.features.codelens then
            --                 vim.lsp.codelens.enable(true, { bufnr = args.buf })
            --             end
            --         end,
            --     },
            -- },
        },
        -- mappings to be set up on attaching of a language server
        mappings = require("lsp.mappings"),
        -- A custom `on_attach` function to be run after the default `on_attach` function
        -- takes two parameters `client` and `bufnr`  (`:h lsp-attach`)
        ---@param client vim.lsp.Client
        ---@param buf integer
        on_attach = function(client, buf)
            require("lsp-format").on_attach(client, buf)
        end,
    },
}
