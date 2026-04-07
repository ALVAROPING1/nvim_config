-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        -- Configure core features of AstroNvim
        features = {
            large_buf = { line_length = false },                          -- set global limits for large files for disabling features like treesitter
            autopairs = true,                                             -- enable autopairs at start
            cmp = true,                                                   -- enable completion at start
            diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
            highlighturl = true,                                          -- highlight URLs at start
            notifications = true,                                         -- enable notifications at start
        },
        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
            virtual_text = true,
            underline = true,
            float = { source = true },
        },
        -- Passed to `vim.filetype.add`
        -- filetypes = {
        --     -- see `:h vim.filetype.add` for usage
        --     extension = {
        --         foo = "fooscript",
        --     },
        --     filename = {
        --         [".foorc"] = "fooscript",
        --     },
        --     pattern = {
        --         [".*/etc/foo/.*"] = "fooscript",
        --     },
        -- },
        -- vim options can be configured here
        options = require("options"),
        -- Mappings can be configured through AstroCore as well.
        mappings = require("mappings"),
        -- Disable search highlight being disabled on cursor movement
        on_keys = { auto_hlsearch = false },
        rooter = { enabled = false },
    },
}
