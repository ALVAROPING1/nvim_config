vim.opt_local.colorcolumn = "120"
vim.opt_local.textwidth = 120
vim.opt_local.formatoptions:remove({ "c" })

require("which-key").add({
    {
        "<LocalLeader>r",
        function()
            require("snacks.debug").run()
        end,
        desc = "Run file",
    },
}, { buffer = 0 })
