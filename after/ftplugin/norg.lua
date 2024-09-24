vim.bo.commentstring = "%|%s|%"

-- Indentation
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"
vim.opt_local.comments = "fb:*,fb:-,fb:~,fn:*,fn:-,fn:~"

require("which-key").add({
    { "<LocalLeader>l", group = "󰙅 List" },
    { "<LocalLeader>t", group = "󰄲 Task" },
    { "<LocalLeader>d", "<Plug>(neorg.tempus.insert-date)", desc = "[neorg] Insert Date" },
    { "<LocalLeader>q", "<Cmd>Neorg return<CR>", desc = "[neorg] Exit document" },
    { "<LocalLeader>r", "<Cmd>Neorg render-latex toggle<CR>", desc = "[neorg] Toggle latex rendering" },
    { "<Plug>(NOP)", "<Plug>(neorg.looking-glass.magnify-code-block)" },
    {
        "<Leader>j",
        function()
            vim.api.nvim_feedkeys("J", "n", true)
            vim.cmd.Neorg("toggle-concealer")
            vim.cmd.Neorg("toggle-concealer")
        end,
        desc = "Join lines",
        buffer = 0,
    },
}, { buffer = 0 })
