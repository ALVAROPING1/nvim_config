-- Config for the lua_ls (lua) language server
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false
            },
            completion = { callSnippet = "Replace" },
        },
    },
}
