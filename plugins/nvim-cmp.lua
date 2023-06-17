-- Configure nvim-cmp
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            "L3MON4D3/cmp-luasnip-choice",
            config = true,
        },
    },
    opts = function(_, opts)
        local cmp = require("cmp")
        opts.sources = cmp.config.sources({
            { name = "nvim_lsp",       priority = 1000 },
            { name = "luasnip",        priority = 750 },
            { name = "buffer",         priority = 500 },
            { name = "path",           priority = 250 },
            { name = "luasnip_choice", priority = 700 }, -- new source
        })
        return opts
    end,
}
