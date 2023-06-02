-- Enable wrap in text like documents
vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable wrap in text like documents",
    pattern = { "gitcommit", "markdown", "text", "plaintex" },
    group = vim.api.nvim_create_augroup("auto_wrap", {}),
    callback = function()
        vim.opt_local.wrap = true
        -- vim.opt_local.spell = true
    end,
})

-- Setup diffview merge conflicts menu for diffview file panel
vim.api.nvim_create_autocmd({ "FileType", "User" }, {
    desc = "Setup diffview merge conflicts menu for diffview file panel",
    pattern = { "DiffviewFiles", "DiffviewDiffBufRead" },
    group = vim.api.nvim_create_augroup("auto_diffview_merge", {}),
    callback = function(args)
        vim.keymap.set("n", "<leader>c", "", { buffer = 0 })

        require("which-key").register({
            ["<leader>c"] = { name = " Merge Conflicts" },
        }, { buffer = args.buf })
    end,
})
