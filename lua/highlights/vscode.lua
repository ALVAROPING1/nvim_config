local blue = "#569CD6"
local light_blue = "#2aaaff"
local red = "#F44747"
local tabline_bg = "#141414"
local grey = "#404040"
local light_grey = "#707070"
local normal = { fg = "#d4d4d4", bg = "#1f1f1f" }
-- Table of overrides/changes to the vscode theme
return {
    -- UI Elements
    TabLineFill = { bg = tabline_bg }, -- Background of buffers line
    LineNr = { link = "VirtualText" },
    CursorLineNr = { fg = "#c6c6c6" },
    CursorLine = { bg = "#282828" },
    CursorColumn = { link = "CursorLine" },
    ColorColumn = { bg = grey },
    PMenuSel = { bg = "#004b72" },
    CurSearch = { link = "Search" },
    LspInlayHint = { link = "VirtualText" },
    SpecialChar = { link = "Special" }, -- Special characters in strings
    VirtualText = { fg = light_grey },  -- Custom group for virtual text

    -- Diagnostics
    Error = { undercurl = true, fg = red, sp = red },

    -- Spelling
    SpellBad = { link = "Error" },
    SpellCap = { link = "DiagnosticUnderlineWarn" },
    SpellRare = { link = "DiagnosticUnderlineInfo" },

    -- Floating windows
    -- Background
    -- NOTE: Handles both hover text and floating windows' background. Hover text looks better with
    -- it, but floating windows without borders don't. By default links to Pmenu, so set floating
    -- windows without borders' background highlight to it and override it for the rest
    NormalFloat = { link = "Normal" },
    LazyNormal = { link = "Pmenu" },
    MasonNormal = { link = "Pmenu" },
    WhichKeyNormal = { link = "Pmenu" },
    -- Borders
    FloatBorder = { fg = "#5A5A5A" },
    NullLsInfoBorder = { link = "FloatBorder" },
    DapUIFloatBorder = { link = "FloatBorder" },

    -- Treesitter
    ["@punctuation.special"] = { link = "@markup.list" }, -- Legacy
    ["@markup.list"] = { fg = blue },
    ["@markup.link.url"] = { fg = light_blue, underline = true },
    ["@markup.underline"] = { link = "Underlined" },
    ["@comment.documentation"] = { fg = blue },
    ["@operator.regex"] = { link = "SpecialChar" },
    ["@punctuation.delimiter.regex"] = { link = "jsRegexpString" },
    ["@module.builtin"] = { link = "@module" },
    ["@keyword.directive.define"] = { link = "Define" },
    ["@string.special.url"] = { link = "@markup.link.url" },
    ["@variable.parameter.builtin"] = { link = "@variable.builtin" },
    -- LSP semantic tokens
    ["@lsp.type.operator.lua"] = { link = "@comment.documentation" },

    -- NeoTree
    NeoTreeCursorLine = { link = "CursorLine" },
    NeoTreeDimText = { fg = "#555555" },
    NeoTreeDirectoryName = { link = "NeoTreeDirectoryIcon" },
    NeoTreeDotFile = { fg = "#626262" },
    NeoTreeFileIcon = { link = "NeoTreeDirectoryIcon" },
    NeoTreeFileNameOpened = { bold = true },
    NeoTreeFilterTerm = { link = "SpecialChar" },
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

    -- Nvim Dap UI
    DapUIModifiedValue = { link = "DiagnosticVirtualTextInfo" },
    DapUIScope = { fg = blue },
    DapUIBreakpointsPath = { link = "DapUIScope" },
    DapUIStoppedThread = { link = "DapUIScope" },
    DapUIWatchesValue = { link = "DapUIScope" },
    DapUIStepBack = { fg = blue },
    DapUIStepBackNC = { link = "DapUIStepBack" },
    DapUIStepInto = { link = "DapUIStepBack" },
    DapUIStepIntoNC = { link = "DapUIStepBack" },
    DapUIStepOut = { link = "DapUIStepBack" },
    DapUIStepOutNC = { link = "DapUIStepBack" },
    DapUIStepOver = { link = "DapUIStepBack" },
    DapUIStepOverNC = { link = "DapUIStepBack" },
    DapUIType = { link = "@type" },

    -- Heirline
    StatusLine = { fg = light_grey, bg = "#242424" },

    -- GitSigns
    GitSignsAdd = { fg = "#487e02" },
    GitSignsChange = { fg = "#1b81a8" },
    GitSignsCurrentLineBlame = { link = "VirtualText" },

    -- Nvim DAP Virtual text
    NvimDapVirtualText = { link = "VirtualText" },
    NvimDapVirtualTextChanged = { link = "DapUIModifiedValue" },

    -- Diffview
    DiffviewDiffDeleteDim = { fg = grey },
    DiffText = { bg = "#185f7a" },
    DiffChange = { bg = "#153947" },

    -- MultiCursor
    MultiCursor = { link = "Visual" },
    MultiCursorMain = { link = "Visual" },

    -- Neorg
    NeorgH1 = { fg = "#bd5eff" },
    NeorgH2 = { fg = "#4fc1ff" },
    NeorgH3 = { fg = "#5eff6c" },
    NeorgH4 = { fg = "#ffbd5e" },
    NeorgH5 = { fg = "#4a90e2" },
    NeorgH6 = { fg = "#ff6e5e" },

    -- nvim-notify
    -- Make sure notifications use the correct background color by copying the `Normal` hl group
    -- instead of linking to it, since Lazy overrides the `Normal` hl group
    NotifyBackground = normal,
    NotifyERRORBody = normal,
    NotifyWARNBody = normal,
    NotifyINFOBody = normal,
    NotifyDEBUGBody = normal,
    NotifyTRACEBody = normal,

    -- Misc Plugins
    IncRenameText = { link = "Search" },               -- Background of replaced text
    LspSignatureActiveParameter = { fg = light_blue }, -- Current parameter in function signature
    TreesitterContext = { bg = grey },
    NeorgContext = { link = "TreesitterContext" },
    MatchParen = { fg = "#11d116" },
    TroubleIconDirectory = { link = "Directory" },
}
