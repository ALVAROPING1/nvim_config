local M = {}

for _, v in ipairs({ "clangd", "ghdl_ls", "lua_ls", "pyright", "rust_analyzer" }) do
    M[v] = require("lsp.config." .. v)
end

return M
