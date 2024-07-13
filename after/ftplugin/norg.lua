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
    ["<localleader>m"] = { group = "Mode" },
    ["<localleader>t"] = { group = "󰄲 Task" },
}, { buffer = 0 })
