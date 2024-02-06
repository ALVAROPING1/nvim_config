vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable settings for text-like documents",
    pattern = { "gitcommit", "markdown", "text", "plaintex", "norg" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.colorcolumn = ""
        vim.opt_local.textwidth = 0
        vim.opt_local.spell = true
        require("astronvim.utils").set_mappings({
            n = {
                ["<leader><leader>l"] = {
                    name = "󰓆 Spelling",
                    l = { "m][s1z=`]", "Fix previous mistake" },
                    i = { "m][s2zg`]", "Ignore previous mistake" },
                    a = { "m][s1zg`]", "Mark previous mistake as good" },
                },
            },
            i = {
                ["<C-l>"] = {
                    name = "󰓆 Spelling",
                    l = { "<C-g>u<Esc>[s1z=`]a<c-g>u", "Fix previous mistake" },
                    i = { "<C-g>u<Esc>[s2zg`]a<c-g>u", "Ignore previous mistake" },
                    a = { "<C-g>u<Esc>[s1zg`]a<c-g>u", "Mark previous mistake as good" },
                },
            },
        }, { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Export with pandoc in supported documents",
    pattern = { "markdown", "norg" },
    callback = function()
        vim.keymap.set("n", "<leader><leader>w", function()
            require("user.pandoc").export()
        end, { desc = "Export to PDF with Pandoc", buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd({ "FileType", "User" }, {
    desc = "Setup diffview merge conflicts menu for diffview file panel",
    pattern = { "DiffviewFiles", "DiffviewDiffBufRead" },
    callback = function()
        vim.keymap.set("n", "<leader>c", "", { buffer = 0 })

        require("which-key").register({
            ["<leader>c"] = { name = " Merge Conflicts" },
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

-- Compile spell dictionaries when changing directory
vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
    desc = "Compile spell dictionaries when changing directory",
    callback = require("user.utils").compile_spell,
})
