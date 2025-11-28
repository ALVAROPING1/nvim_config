vim.opt_local.formatoptions:append("t")

require("which-key").add({
    {
        "<LocalLeader>w",
        function()
            local opts = vim.opt_local.formatoptions:get()
            if opts.t then
                vim.opt_local.formatoptions:remove("t")
            else
                vim.opt_local.formatoptions:append("t")
            end
        end,
        desc = "Toggle automatic word wrap",
    },
}, { buffer = 0 })
