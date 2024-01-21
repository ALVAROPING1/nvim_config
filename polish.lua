-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

    -- Disable search highlight being disabled on cursor movement
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])

    -- Replace deleted lines symbol with diagonal lines in diff view
    vim.opt.fillchars:append({ diff = "╱" })

    require("user.polish.custom_icons")
    require("user.polish.autocmds")

    -- Remove unused friendly-snippets snippets
    require("luasnip").available(function(snippet)
        local names = { "copyright", "dateMDY", "Lorem Ipsum Paragraph", "Lorem Ipsum Sentence" }
        return vim.tbl_contains(names, snippet.name) and snippet:invalidate()
    end)

    -- Adds rounded borders to the LSPInfo floating window
    require("lspconfig.ui.windows").default_options.border = "rounded"
    -- Adds the after folder to the runtime path to define custom ftplugins
    vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/user/after/")
end
