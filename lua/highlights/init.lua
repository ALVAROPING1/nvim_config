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
    ["@markup.heading.1.markdown"] = { link = "@markup.heading" },
    ["@markup.heading.2.markdown"] = { link = "@markup.heading" },
    ["@markup.heading.3.markdown"] = { link = "@markup.heading" },
    ["@markup.heading.4.markdown"] = { link = "@markup.heading" },
    ["@markup.heading.5.markdown"] = { link = "@markup.heading" },
    ["@markup.heading.6.markdown"] = { link = "@markup.heading" },

    -- Which key
    ["WhichKeyIconAzure"] = { link = "MiniIconsAzure" },
    ["WhichKeyIconBlue"] = { link = "MiniIconsBlue" },
    ["WhichKeyIconGrey"] = { link = "MiniIconsGrey" },
    ["WhichKeyIconOrange"] = { link = "MiniIconsOrange" },
    ["WhichKeyIconYellow"] = { link = "MiniIconsYellow" },
    ["WhichKeySeparator"] = { link = "MiniIconsGreen" },
    ["WhichKeyValue"] = { link = "MiniIconsGreen" },

    -- Flash
    FlashBackdrop = { fg = "#777777" },
    FlashMatch = { link = "TelescopeMatching" },
    FlashLabel = { fg = red },
    FlashCurrent = { fg = "#487e02", bold = true },

    -- Colorful-winsep
    NvimSeparator = { fg = "#3DAEE9" },

    BlinkCmpLabelDeprecated = { link = "CmpItemAbbrDeprecated" },

    DevIconMarkdown = { fg = "#519aba" },
}
