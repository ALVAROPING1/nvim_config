vim.bo.commentstring = "%|%s|%"

-- Indentation
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"
vim.opt_local.comments = "fb:*,fb:-,fb:~,fn:*,fn:-,fn:~"
vim.opt_local.foldmethod = "expr"

require("which-key").add({
    ["<localleader>l"] = { group = "󰙅 List" },
    ["<localleader>t"] = { group = "󰄲 Task" },
    { "<localleader>d", "<Plug>(neorg.tempus.insert-date)",   desc = "[neorg] Insert Date" },
    { "<localleader>q", "<Cmd>Neorg return<CR>",              desc = "[neorg] Exit document" },
    { "<localleader>r", "<Cmd>Neorg render-latex toggle<CR>", desc = "[neorg] Toggle latex rendering" },
}, { buffer = 0 })
