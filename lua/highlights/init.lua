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
    ["@markup.link"] = { link = "@punctuation.bracket" },

    -- Leap
    LeapMatch = { fg = "#487e02" },
    LeapLabel = { fg = red },
    LeapBackdrop = { fg = "#777777" },

    -- Colorful-winsep
    NvimSeparator = { fg = "#3DAEE9" },
}
