local devicons = require("nvim-web-devicons")
local utils = require("astroui")

devicons.set_icon_by_filetype({
    toggleterm = "terminal",
    latex = "tex",
    mason = "lsp",
    lspinfo = "lsp",
    ["null-ls-info"] = "lsp",
    cargo = "rs",
})

devicons.set_icon({
    md = {
        icon = "",
        color = "#519aba",
        name = "Markdown",
    },
    latex = {
        icon = "󰙩",
        color = "#3D6117",
        cterm_color = "22",
        name = "Tex",
    },
    ["Neo-tree"] = {
        icon = utils.get_icon("FolderClosed"),
        color = utils.get_hlgroup("Directory").fg,
        name = "NeoTree",
    },
    TelescopePrompt = {
        icon = utils.get_icon("Search"),
        name = "Telescope",
    },
    Lazy = {
        icon = "󰒲",
        color = require("highlights.vscode").LazyH1.bg,
        name = "Lazy",
    },
    lsp = {
        icon = utils.get_icon("ActiveLSP"),
        color = require("highlights.vscode").LazyH1.bg,
        name = "LSPInfo",
    },
    alpha = {
        icon = "α",
        color = require("highlights.vscode").LazyH1.bg,
        name = "Alpha",
    },
})
