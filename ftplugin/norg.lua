vim.bo.commentstring = "%|%s|%"

-- Indentation
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"
vim.opt_local.comments = "fb:*,fb:-,fb:~,fn:*,fn:-,fn:~"

vim.b.snacks_indent = false

require("which-key").add({
    buffer = 0,
    { "<LocalLeader>l", group = "󰙅 List" },
    { "<LocalLeader>t", group = "󰄲 Task" },
    { "<LocalLeader>d", "<Plug>(neorg.tempus.insert-date)", desc = "[neorg] Insert Date" },
    { "<LocalLeader>q", "<Cmd>Neorg return<CR>", desc = "[neorg] Exit document" },
    {
        "<LocalLeader>c",
        "<Cmd>Neorg toggle-concealer<CR><Cmd>Neorg toggle-concealer<CR>",
        desc = "[neorg] Restart concealer",
    },
    { "<Plug>(NOP)", "<Plug>(neorg.looking-glass.magnify-code-block)" },
    { "<Leader>j",   "J<Cmd>Neorg toggle-concealer<CR><Cmd>Neorg toggle-concealer<CR>", desc = "Join lines" },
})
