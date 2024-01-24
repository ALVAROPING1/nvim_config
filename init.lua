return {
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
    },
    lsp = {
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
            "vhdl_ls",
        },
    },
    -- Configure require("lazy").setup() options
    lazy = {
        defaults = { lazy = true },
        performance = {
            rtp = {
                -- customize default disabled vim plugins
                disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
            },
        },
    },
    heirline = {
        -- define the separators between each section
        separators = {
            left = { "", " " }, -- separator for the left side of the statusline
            right = { " ", "" }, -- separator for the right side of the statusline
            tab = { "", "" },
        },
        -- add new colors that can be used by heirline
        colors = function(hl)
            local get_hlgroup = require("astronvim.utils").get_hlgroup
            local white = "#dee1e6"
            local lightbg = "#303030"
            -- use helper function to get highlight group properties
            hl.mode_fg = "bg"
            hl.blank_bg = "#444444"
            hl.file_info_bg = lightbg
            hl.file_info_fg = white
            hl.git_branch_fg = hl.fg
            hl.cmd_info_fg = white
            hl.lsp_progress_fg = "#B5CEA8"
            hl.lsp_clients_fg = "#60a6e0"
            hl.folder_icon_bg = get_hlgroup("Error").fg
            hl.folder_icon_fg = "bg"
            hl.folder_bg = lightbg
            hl.folder_fg = white
            hl.nav_icon_bg = get_hlgroup("DiagnosticInfo").fg
            hl.nav_icon_fg = "bg"
            hl.nav_bg = lightbg
            hl.nav_fg = hl.nav_icon_bg
            return hl
        end,
        attributes = { mode = { bold = true } },
    },
}
