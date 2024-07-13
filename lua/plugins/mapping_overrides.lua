---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
        local maps = opts.mappings
        ---@cast maps -nil
        local maps_n = maps.n
        ---@cast maps_n -nil
        local tbl_move = require("utils").tbl_move
        -- Core mappings
        -- Navigate buffer tabs with `Tab` and `Shift-Tab`
        tbl_move(maps_n, "<Tab>", "]b")
        tbl_move(maps_n, "<S-Tab>", "[b")
        -- Move find themes from `ft` to `fT` since it will be more rarely used than find TODOs
        tbl_move(maps_n, "<Leader>fT", "<Leader>ft")
        -- Astrocommunity mappings
        tbl_move(maps_n, "<Leader>J", "<Leader>m")   -- Treesj
        tbl_move(maps_n, "<Leader>xl", "<Lader>xL")  -- Trouble location list
        tbl_move(maps_n, "<Leader>xq", "<Leader>xQ") -- Trouble quickfix list
    end,
}
