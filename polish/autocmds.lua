-- Enable wrap in text like documents
vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable wrap in text like documents",
    pattern = { "gitcommit", "markdown", "text", "plaintex", "norg" },
    group = vim.api.nvim_create_augroup("auto_wrap", {}),
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Setup diffview merge conflicts menu for diffview file panel
vim.api.nvim_create_autocmd({ "FileType", "User" }, {
    desc = "Setup diffview merge conflicts menu for diffview file panel",
    pattern = { "DiffviewFiles", "DiffviewDiffBufRead" },
    group = vim.api.nvim_create_augroup("auto_diffview_merge", {}),
    callback = function()
        vim.keymap.set("n", "<leader>c", "", { buffer = 0 })

        require("which-key").register({
            ["<leader>c"] = { name = " Merge Conflicts" },
        }, { buffer = 0 })
    end,
})

-- HACK: Fix for diffview breaking the tabline when opened
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
    desc = "Fix for tabline breaking after diffview is opened",
    group = vim.api.nvim_create_augroup("auto_diffview_fix", {}),
    callback = function()
        if not vim.t.bufs then
            vim.t.bufs = {}
        end
    end,
})

-- Auto-save when changing buffers
vim.api.nvim_create_autocmd("BufLeave", {
    desc = "Auto-save when changing buffers",
    group = vim.api.nvim_create_augroup("autosave", {}),
    callback = function()
        if vim.bo.buflisted and vim.bo.modifiable and vim.bo.modified then
            vim.cmd("silent! write")
        end
    end,
})

-- Compile spell dictionaries when changing directory
vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
    desc = "Compile spell dictionaries when changing directory",
    group = vim.api.nvim_create_augroup("autospell", {}),
    callback = require("user.utils").compile_spell,
})
