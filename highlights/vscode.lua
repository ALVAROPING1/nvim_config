local blue = "#569CD6"
local light_blue = "#2aaaff"
local red = "#F44747"
local tabline_bg = "#141414"
local CursorLineBg = "#282828"
local grey = "#404040"
local light_grey = "#707070"
-- Table of overrides/changes to the vscode theme
return {
    -- UI Elements
    TabLineFill = { bg = tabline_bg }, -- Background of buffers line
    LineNr = { fg = light_grey },
    CursorLineNr = { fg = "#c6c6c6" },
    CursorLine = { bg = CursorLineBg },
    CursorColumn = { link = "CursorLine" },
    ColorColumn = { bg = grey },
    SpecialChar = { link = "Special" }, -- Special characters in strings

    -- Diagnostics
    Error = { undercurl = true, fg = red, sp = red },
    DiagnosticUnnecessary = { fg = "#8D8D8D" }, -- Used by python

    -- Spelling
    SpellBad = { link = "Error" },
    SpellCap = { link = "DiagnosticUnderlineInfo" },
    SpellRare = { link = "DiagnosticUnderlineWarn" },

    -- Floating windows
    -- Background
    -- NOTE: Handles both hover text and floating windows' background. Hover text looks better with
    -- it, but floating windows without borders don't. By default links to Pmenu, so set floating
    -- windows without borders' background highlight to it and override it for the rest
    NormalFloat = { link = "Normal" },
    LazyNormal = { link = "Pmenu" },
    MasonNormal = { link = "Pmenu" },
    WhichKeyFloat = { link = "Pmenu" },
    -- Borders
    FloatBorder = { link = "LspInfoBorder" },
    NullLsInfoBorder = { link = "FloatBorder" },

    -- Treesitter
    ["@punctuation.special"] = { link = "@markup.list" }, -- Legacy
    ["@markup.list"] = { fg = blue },
    ["@markup.link.url"] = { fg = light_blue, underline = true },
    ["@markup.underline"] = { link = "Underlined" },
    ["@comment.documentation"] = { fg = blue },

    -- NeoTree
    NeoTreeGitAdded = { link = "NvimTreeGitRenamed" },
    NeoTreeGitDeleted = { link = "NvimTreeGitDeleted" },
    NeoTreeGitIgnored = { link = "NvimTreeGitIgnored" },
    NeoTreeGitModified = { link = "NvimTreeGitDirty" },
    NeoTreeGitUnstaged = { link = "NvimTreeGitDirty" },
    NeoTreeGitUntracked = { link = "NvimTreeGitRenamed" },
    NeoTreeGitStaged = { link = "NvimTreeGitStaged" },
    NeoTreeTitleBar = { fg = "fg", bg = grey },
    NeoTreeFloatBorder = { fg = grey },
    NeoTreeTabSeparatorActive = { link = "NvimTreeVertSplit" },
    NeoTreeTabSeparatorInactive = { fg = tabline_bg, bg = tabline_bg },

    -- Lazy
    LazyButton = { fg = "fg", bg = grey },
    LazyButtonActive = { bg = "#264F78", bold = true },
    LazyH1 = { fg = "#000000", bg = light_blue, bold = true },
    LazySpecial = { fg = blue },

    -- Mason
    MasonHeader = { link = "LazyH1" },
    MasonHeaderSecondary = { link = "MasonHeaderSecondary" },
    MasonHighlightBlock = { link = "Visual" },
    MasonHighlightBlockSecondary = { link = "MasonHighlightBlockSecondary" },
    MasonHighlightBlockBold = { link = "LazyButtonActive" },
    MasonHighlightBlockBoldSecondary = { link = "MasonHighlightBlockBold" },
    MasonMutedBlock = { link = "LazyButton" },
    MasonHighlight = { fg = blue },
    MasonHighlightSecondary = { link = "MasonHighlight" },
    MasonMuted = { link = "DiagnosticError" },

    -- Heirline
    StatusLine = { fg = light_grey, bg = "#242424" },

    -- GitSigns
    GitSignsAdd = { fg = "#487e02" },
    GitSignsChange = { fg = "#1b81a8" },

    -- Nvim DAP Virtual text
    NvimDapVirtualText = { fg = light_grey },
    NvimDapVirtualTextChanged = { link = "DiagnosticVirtualTextInfo" },

    -- Diffview
    DiffviewDiffDeleteDim = { fg = grey },
    DiffText = { bg = "#185f7a" },
    DiffChange = { bg = "#153947" },

    -- MultiCursor
    MultiCursor = { link = "Visual" },
    MultiCursorMain = { link = "Visual" },

    -- Misc Plugins
    GitBlameText = { fg = light_grey, bg = CursorLineBg }, -- GitBlame text on current line
    IncRenameText = { link = "Search" },                   -- Background of replaced text
    LspSignatureActiveParameter = { fg = light_blue },     -- Current parameter in function signature
    TreesitterContext = { bg = grey },
    NeorgContext = { link = "TreesitterContext" },
    MatchParen = { fg = "#11d116" },
}
