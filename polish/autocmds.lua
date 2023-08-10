-- Enable wrap in text like documents
vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable wrap in text like documents",
    pattern = { "gitcommit", "markdown", "text", "plaintex" },
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
    callback = function(args)
        vim.keymap.set("n", "<leader>c", "", { buffer = 0 })

        require("which-key").register({
            ["<leader>c"] = { name = " Merge Conflicts" },
        }, { buffer = args.buf })
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
    callback = function(args)
        if vim.bo.buflisted and vim.bo.modifiable and vim.bo.modified then
            -- HACK: Formating the buffer can lag when opening neotree at the same time, so wait a bit before formatting the buffer
            vim.defer_fn(function()
                vim.api.nvim_buf_call(args.buf, function()
                    -- Trigger formatting before saving to make sure its changes are saved
                    -- (leaving the buffer cancels the autosave after formatting)
                    require("lsp-format").format({ fargs = { "sync" } })
                    vim.cmd("silent! write")
                end)
            end, 10)
        end
    end,
})
