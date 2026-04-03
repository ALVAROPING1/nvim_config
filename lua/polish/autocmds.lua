vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable settings for text-like documents",
    pattern = { "gitcommit", "markdown", "text", "plaintex", "norg" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.colorcolumn = ""
        vim.opt_local.textwidth = 0
        vim.opt_local.spell = true
        local utils = require("utils")
        require("astrocore").set_mappings({
            n = {
                ["<Leader><Leader>l"] = { group = "󰓆 Spelling" },
                ["<Leader><Leader>ll"] = { utils.restore_view("[s1z="), desc = "Fix previous mistake" },
                ["<Leader><Leader>li"] = { utils.restore_view("[s2zg"), desc = "Ignore previous mistake" },
                ["<Leader><Leader>la"] = { utils.restore_view("[s1zg"), desc = "Mark previous mistake as good" },
            },
            i = {
                ["<C-l>"] = { group = "󰓆 Spelling" },
                ["<C-l>l"] = { "<C-g>u<Esc>[s1z=`]a<c-g>u", desc = "Fix previous mistake" },
                ["<C-l>i"] = { "<C-g>u<Esc>[s2zg`]a<c-g>u", desc = "Ignore previous mistake" },
                ["<C-l>a"] = { "<C-g>u<Esc>[s1zg`]a<c-g>u", desc = "Mark previous mistake as good" },
            },
        }, { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Export with pandoc in supported documents",
    pattern = { "markdown", "norg" },
    callback = function()
        vim.keymap.set("n", "<Leader><Leader>w", function()
            require("pandoc").export()
        end, { desc = "Export to PDF with Pandoc", buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd({ "FileType", "User" }, {
    desc = "Setup diffview merge conflicts menu for diffview file panel",
    pattern = { "DiffviewFiles", "DiffviewDiffBufRead" },
    callback = function()
        vim.keymap.set("n", "<Leader>c", "", { buffer = 0 })

        require("which-key").add({
            { "<Leader>c", group = " Merge Conflicts" },
        }, { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    desc = "Auto-save when changing buffers",
    callback = function()
        if vim.bo.buflisted and vim.bo.modifiable and vim.bo.modified then
            vim.cmd("silent! write")
        end
    end,
})

vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
    desc = "Compile spell dictionaries when changing directory",
    callback = function()
        local paths = vim.split(vim.fn.glob(".spell/*.add"), "\n")
        if paths[1] ~= "" then
            for _, file in pairs(paths) do
                vim.cmd("silent mkspell! " .. file)
            end
        end
    end,
})

-- TODO: remove when Lazy.nvim is fixed
vim.api.nvim_create_autocmd("FileType", {
    desc = "Fix backdrop for Lazy.nvim window",
    pattern = "lazy_backdrop",
    callback = function(ctx)
        local win = vim.fn.win_findbuf(ctx.buf)[1]
        vim.api.nvim_win_set_config(win, { border = "none" })
    end,
})
