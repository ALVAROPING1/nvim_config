local blue = "#0095FF"
local red = "#FF0000"
return {
    -- this table overrides highlights in all themes
    -- Normal = { bg = "#000000" },
    -- Rainbow Delimiters
    Delimiter1 = { fg = blue },
    Delimiter2 = { fg = red },
    Delimiter3 = { fg = "#32ff32" },

    -- Treesitter
    ["@punctuation.bracket"] = { fg = blue },

    -- Flash
    FlashBackdrop = { fg = "#777777" },
    FlashMatch = { link = "TelescopeMatching" },
    FlashLabel = { fg = red },
    FlashCurrent = { fg = "#487e02", bold = true },

    -- Colorful-winsep
    NvimSeparator = { fg = "#3DAEE9" },

    BlinkCmpLabelDeprecated = { link = "CmpItemAbbrDeprecated" },
}
