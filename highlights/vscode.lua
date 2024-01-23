-- Table of overrides/changes to the vscode theme
return {
    -- UI Elements
    TabLineFill = { bg = "#141414" }, -- Backgroup of buffers line
    LineNr = { fg = "#858585" },
    CursorLineNr = { fg = "#c6c6c6" },
    CursorLine = { bg = "#282828" },
    CursorColumn = { link = "CursorLine" },
    ColorColumn = { bg = "#404040" },
    -- SpecialChar = { link = "Special" }, -- Can be removed?
    -- Diagnostics
    DiagnosticUnnecessary = { fg = "#8D8D8D" },
    -- Spelling
    -- SpellBad = { underline = false, fg = "#F44747" },
    SpellCap = { undercurl = true, fg = "#569CD6", sp = "#569CD6" },
    SpellRare = { undercurl = true, fg = "#DCDCAA", sp = "#DCDCAA" },

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
    ["@punctuation.special"] = { fg = "#569CD6" }, -- Legacy
    ["@markup.list"] = { fg = "#569CD6" },
    ["@markup.link.url"] = { fg = "#2aaaff", underline = true },
    ["@markup.underline"] = { underline = true },
    ["@comment.documentation"] = { fg = "#569cd6" },

    -- NeoTree
    NeoTreeGitAdded = { fg = "#73c991" },
    NeoTreeGitDeleted = { fg = "#c74e39" },
    NeoTreeGitIgnored = { fg = "#8c8c8c" },
    NeoTreeGitModified = { fg = "#e2c08d" },
    NeoTreeGitUnstaged = { fg = "#e2c08d" },
    NeoTreeGitUntracked = { fg = "#73c991" },
    NeoTreeGitStaged = { fg = "#e2c08d" },
    NeoTreeTitleBar = { fg = "#d4d4d4", bg = "#444444" },
    NeoTreeTabSeparatorActive = { fg = "#1E1E1E", bg = "#1E1E1E" },
    NeoTreeTabSeparatorInactive = { fg = "#141414", bg = "#141414" },
    NeoTreeDirectoryIcon = { fg = "#569CD6" },
    NeoTreeDirectoryName = { fg = "#569CD6" },

    -- Lazy
    LazyButton = { fg = "#D4D4D4", bg = "#404040" },
    LazyButtonActive = { bg = "#264F78", bold = true },
    LazyH1 = { fg = "#000000", bg = "#2aaaff", bold = true },
    LazySpecial = { fg = "#569CD6" },

    -- Mason
    MasonHeader = { link = "LazyH1" },
    MasonHeaderSecondary = { link = "MasonHeaderSecondary" },
    MasonHighlightBlock = { bg = "#264F78" },
    MasonHighlightBlockSecondary = { link = "MasonHighlightBlockSecondary" },
    MasonHighlightBlockBold = { link = "LazyButtonActive" },
    MasonHighlightBlockBoldSecondary = { link = "MasonHighlightBlockBold" },
    MasonMutedBlock = { link = "LazyButton" },
    MasonHighlight = { link = "DiagnosticInfo" },
    MasonHighlightSecondary = { link = "MasonHighlight" },
    MasonMuted = { link = "DiagnosticError" },

    -- Heirline
    StatusLine = { fg = "#626262", bg = "#242424" },

    -- GitSigns
    GitSignsAdd = { fg = "#487e02" },
    GitSignsChange = { fg = "#1b81a8" },

    -- Nvim DAP Virtual text
    NvimDapVirtualText = { fg = "#707070" },
    NvimDapVirtualTextChanged = { link = "DiagnosticVirtualTextInfo" },

    -- Diffview
    DiffviewDiffDeleteDim = { fg = "#414141" },
    DiffText = { bg = "#185f7a" },
    DiffChange = { bg = "#153947" },

    -- MultiCursor
    MultiCursor = { link = "Visual" },
    MultiCursorMain = { link = "Visual" },

    -- Misc Plugins
    GitBlameText = { fg = "#707070", bg = "#282828" }, -- GitBlame text on current line
    IncRenameText = { bg = "#613214" },                -- Background of replaced text
    LspSignatureActiveParameter = { fg = "#2aaaff" },  -- Current parameter in function signature
    TreesitterContext = { bg = "#404040" },
    NeorgContext = { link = "TreesitterContext" },
    MatchParen = { fg = "#11d116" },
}
