-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- Replace deleted lines symbol with diagonal lines in diff view
vim.opt.fillchars:append({ diff = "╱" })

require("polish.autocmds")

-- Remove unused friendly-snippets snippets
require("luasnip").available(function(snippet)
    local names = { "copyright", "dateMDY", "Lorem Ipsum Paragraph", "Lorem Ipsum Sentence" }
    return vim.list_contains(names, snippet.name) and snippet:invalidate()
end)
