vim.opt_local.conceallevel = 2
vim.bo.commentstring = "%|%s|%"
vim.opt_local.comments = ""

require("which-key").register({
    ["<localleader>l"] = { name = "󰙅 List" },
    ["<localleader>m"] = { name = "Mode" },
    ["<localleader>t"] = { name = "󰄲 Task" },
}, { buffer = 0 })
