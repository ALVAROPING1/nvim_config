-- Configure completion symbols
return {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
        -- set some missing symbol types
        opts.symbol_map = {
            Boolean = "",
            Namespace = "",
            Null = "",
            Number = "",
        }
        return opts
    end,
}
