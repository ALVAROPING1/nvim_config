-- Enable wrap/spell in text like documents
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "text", "plaintex" },
    group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Setup diffview merge conflicts menu for diffview file panel
vim.api.nvim_create_autocmd({ "FileType", "User" }, {
    pattern = { "DiffviewFiles", "DiffviewDiffBufRead" },
    group = vim.api.nvim_create_augroup("auto_diffview_merge", { clear = true }),
    callback = function(args)
        vim.keymap.set("n", "<leader>c", "", { buffer = 0 })

        require("which-key").register({
            ["<leader>c"] = { name = " Merge Conflicts" },
        }, { buffer = args.buf })
    end,
})
