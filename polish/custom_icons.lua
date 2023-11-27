require("nvim-web-devicons").set_icon({
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
    ["neo-tree"] = {
        icon = require("astronvim.utils").get_icon("FolderClosed"),
        color = require("user.highlights.vscode").NeoTreeDirectoryIcon.fg,
        name = "NeoTree",
    },
    TelescopePrompt = {
        icon = require("astronvim.utils").get_icon("Search"),
        name = "Telescope",
    },
    lazy = {
        icon = "󰒲",
        color = require("user.highlights.vscode").LazyH1.bg,
        name = "Lazy",
    },
    lsp = {
        icon = require("astronvim.utils").get_icon("ActiveLSP"),
        color = require("user.highlights.vscode").LazyH1.bg,
        name = "LSPInfo",
    },
    cargo = {
        icon = "",
        color = "#dea584",
        name = "Cargo",
    },
})
