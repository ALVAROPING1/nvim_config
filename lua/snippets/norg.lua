---------------------------------------------------------------------------------------------------------------------------------
--- Luasnip imports
---------------------------------------------------------------------------------------------------------------------------------

local ls = require("snippets.luasnips")
local parse_snippet = ls.parse_snippet

---------------------------------------------------------------------------------------------------------------------------------
--- Create snippets
---------------------------------------------------------------------------------------------------------------------------------

-- Create custom autosnippets
local snippets = {
    parse_snippet({ trig = "embed", name = "Embed", desc = "embed block" }, "@embed ${1:lang}\n$2\n@end"),
    parse_snippet({ trig = "latex", name = "Embed latex", desc = "latex block" }, "@embed latex\n$1\n@end"),
}
local autosnippets = {
    parse_snippet({ trig = "tm", name = "Inline math (rigid)" }, "\\$|$1|\\$"),
    parse_snippet({ trig = "ttm", name = "Inline math (simple)" }, "\\$$1\\$"),
    parse_snippet({ trig = "dm", name = "Display math" }, "@math\n$1\n@end"),
}

return snippets, autosnippets
