local M = {}

for _, v in ipairs({ "clangd", "ghdl_ls", "lua_ls", "basedpyright", "rust_analyzer", "typos_lsp" }) do
    M[v] = require("lsp.config." .. v)
end

return M
