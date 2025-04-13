-- Configure completion symbols
---@type LazySpec
return {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
        -- set some missing symbol types
        opts.symbol_map = require("icons").lspkind
    end,
}
