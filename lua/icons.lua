---@class MiniIconsSpec
---@field glyph string? Icon
---@field hl string? Highlight group

---@alias MiniIconsCategory table<string, MiniIconsSpec>

-- Custom icons to use. Commented lines use the default
return {
    -- ActiveLSP = "",
    -- ActiveTS = "",
    -- ArrowLeft = "",
    -- ArrowRight = "",
    -- BufferClose = "󰅖",
    -- DapBreakpoint = "",
    -- DapBreakpointCondition = "",
    -- DapBreakpointRejected = "",
    DapLogPoint = "",
    DapStopped = "",
    -- DefaultFile = "󰈙",
    -- Diagnostic = "󰒡",
    -- DiagnosticError = "",
    -- DiagnosticHint = "󰌵",
    DiagnosticInfo = " ",
    -- DiagnosticWarn = "",
    Ellipsis = "",
    -- FileModified = "",
    -- FileReadOnly = "",
    -- FoldClosed = "",
    -- FoldOpened = "",
    -- FoldSeparator = " ",
    -- FolderClosed = "",
    -- FolderEmpty = "",
    -- FolderOpen = "",
    -- Git = "󰊢",
    -- GitAdd = "",
    -- GitBranch = "",
    -- GitChange = "",
    -- GitConflict = "",
    -- GitDelete = "",
    -- GitIgnored = "◌",
    -- GitRenamed = "➜",
    GitStaged = "",
    GitUnstaged = "",
    GitUntracked = "󰓎",
    -- LSPLoaded = "",
    -- LSPLoading1 = "",
    -- LSPLoading2 = "󰀚",
    -- LSPLoading3 = "",
    -- MacroRecording = "",
    -- Paste = "󰅌",
    ScrollText = "",
    -- Search = "",
    -- Selected = "❯",
    -- Spellcheck = "󰓆",
    -- TabClose = "󰅙",
    VimIcon = "",
    -- stylua: ignore
    ---@format disable-next
    ---@type MiniIconsCategory
    directory = {
        doc             = {              hl = "MiniIconsBlue"               },
        docs            = {              hl = "MiniIconsBlue"               },
        src             = {              hl = "MiniIconsBlue"               },
    },
    -- stylua: ignore
    ---@format disable-next
    ---@type MiniIconsCategory
    file = {
        CODEOWNERS      = {              hl = "MiniIconsBlue"               },
        LICENSE         = {              hl = "MiniIconsYellow"             },
        ['LICENSE.md']  = {              hl = "MiniIconsYellow"             },
        ['LICENSE.txt'] = {              hl = "MiniIconsYellow"             },
        TODO            = {              hl = "MiniIconsBlue"               },
        ['TODO.md']     = {              hl = "MiniIconsBlue"               },
        ['init.lua']    = { glyph = "", hl = "DevIconLua"                  },
    },
    -- stylua: ignore
    ---@format disable-next
    ---@type MiniIconsCategory
    lsp = {
        array         = { glyph = "󰅪", hl = "@variable"                     },
        boolean       = { glyph = "󰨙", hl = "@variable"                     },
        class         = { glyph = "󰠱", hl = "CmpItemKindConstructor"        },
        color         = { glyph = "󰏘", hl = "cssColor"                      },
        constant      = { glyph = "󰏿", hl = "@constant"                     },
        constructor   = { glyph = "", hl = "CmpItemKindConstructor"        },
        enum          = { glyph = "", hl = "@variable"                     },
        enummember    = { glyph = "", hl = "@variable"                     },
        event         = { glyph = "", hl = "@constant"                     },
        field         = { glyph = "󰜢", hl = "@variable"                     },
        file          = { glyph = "󰈙", hl = "@markup.link"                  },
        folder        = { glyph = "󰉋", hl = "@markup.link"                  },
        ['function']  = { glyph = "󰊕", hl = "@keyword"                      },
        interface     = { glyph = "", hl = "@variable"                     },
        key           = { glyph = "󰌆", hl = "@variable"                     },
        keyword       = { glyph = "󰌋", hl = "MiniIconsGrey"                 },
        method        = { glyph = "", hl = "MiniIconsPurple"               },
        module        = { glyph = "", hl = "@module"                       },
        namespace     = { glyph = "", hl = "@module"                       },
        null          = { glyph = "", hl = "MiniIconsGrey"                 },
        number        = { glyph = "󰎠", hl = "@variable"                     },
        object        = { glyph = "󰀚", hl = "@variable"                     },
        operator      = { glyph = "󰆕", hl = "MiniIconsGrey"                 },
        package       = { glyph = "󰏗", hl = "@module"                       },
        property      = { glyph = "", hl = "@property"                     },
        reference     = { glyph = "󰈇", hl = "@variable.parameter.reference" },
        snippet       = { glyph = "", hl = "MiniIconsGrey"                 },
        string        = { glyph = "󰀬", hl = "@variable"                     },
        struct        = { glyph = "󰙅", hl = "@structure"                    },
        text          = { glyph = "󰀬", hl = "@variable"                     },
        typeparameter = { glyph = "󰊄", hl = "@type"                         },
        unit          = { glyph = "󰑭", hl = "MiniIconsGrey"                 },
        value         = { glyph = "󰎠", hl = "@variable"                     },
        variable      = { glyph = "󰀫", hl = "@variable"                     },
    },
    -- stylua: ignore
    ---@format disable-next
    ---@class DeviconsOverrides
    filetype = {
        ---@type string[]?
        mini_icons = { "cfg", "conf", "git", "gitattributes", "gitcommit", "gitconfig", "gitignore", "go", "lua", "typescript", "vim", "vue" },
        ---@type string[]?
        mini_all   = { "bib", "checkhealth", "csv", "desktop", "diff", "javascript", "json", "json5", "jsonc", "query", "sql", "yaml" },
        ---@type MiniIconsCategory?
        overrides = {
            -- Default filetypes
            markdown           = { hl = "IconMarkdown" },
            latex              = { hl = "DevIconTex",      glyph = "" },
            -- Plugin filetypes
            cargo              = { hl = "DevIconRs",       glyph = "" },
            ["neo-tree"]       = { hl = "MiniIconsBlue"   },
            ["neo-tree-popup"] = { hl = "MiniIconsBlue"   },
            ["null-ls-info"]   = { hl = "MiniIconsBlue",   glyph = "" },
            toggleterm         = { hl = "DevIconTerminal", glyph = "" },
            snacks_dashboard   = { hl = "MiniIconsBlue",   glyph = "󰕮" },
            snacks_notif       = { hl = "MiniIconsBlue",   glyph = "" },
            snacks_picker      = { hl = "MiniIconsGrey",   glyph = "" },
        }
    },
    ---@class DeviconsOverrides
    extension = { mini_all = { "ipynb" } },
}
