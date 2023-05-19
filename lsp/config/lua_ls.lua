-- Config for the lua_ls (lua) language server
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }, -- Get the language server to recognize the `vim` global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
                checkThirdParty = false,
            },
            completion = { callSnippet = "Replace" },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
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
        },
    },
}
