-- Configure completion symbols
return {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
        -- set some missing symbol types
        opts.symbol_map = require("user.icons").lspkind
    end,
}
