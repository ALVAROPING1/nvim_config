---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
        local maps = opts.mappings
        local tbl_move = require("utils").tbl_move
        -- Core mappings
        -- Navigate buffer tabs with `Tab` and `Shift-Tab`
        tbl_move(maps.n, "<Tab>", "]b")
        tbl_move(maps.n, "<S-Tab>", "[b")
        -- Move find themes from `ft` to `fT` since it will be more rarely used than find TODOs
        tbl_move(maps.n, "<Leader>fT", "<Leader>ft")
        -- Astrocommunity mappings
        tbl_move(maps.n, "<Leader>J", "<Leader>m") -- Treesj
    end,
}
