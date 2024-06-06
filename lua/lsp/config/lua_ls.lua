-- Config for the lua_ls (lua) language server
---@diagnostic disable: missing-fields
---@type lspconfig.options.lua_ls
return {
    settings = {
        Lua = {
            completion = { callSnippet = "Replace" },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            format = {
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    quote_style = "double",
                    call_arg_parentheses = "keep",
                    trailing_table_separator = "smart",
                    align_call_args = true,
                    break_all_list_when_line_exceed = true,
                    auto_collapse_lines = true,
                },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
            },
        },
    },
}
