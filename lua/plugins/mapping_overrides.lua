---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
        --- Moves a value of a table to a different key
        ---@param tbl table
        ---@param dest any
        ---@param src any
        local function tbl_move(tbl, dest, src)
            tbl[dest] = tbl[src]
            tbl[src] = nil
        end

        local maps = opts.mappings
        ---@cast maps -nil
        local maps_n = maps.n
        ---@cast maps_n -nil
        -- Core mappings
        -- Navigate buffer tabs with `Tab` and `Shift-Tab`
        tbl_move(maps_n, "<Tab>", "]b")
        tbl_move(maps_n, "<S-Tab>", "[b")
        -- Move find themes from `ft` to `fT` since it will be more rarely used than find TODOs
        tbl_move(maps_n, "<Leader>fT", "<Leader>ft")
        -- Astrocommunity mappings
        tbl_move(maps_n, "<Leader>J", "<Leader>m")   -- Treesj
    end,
}
