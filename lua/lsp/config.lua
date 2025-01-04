local M = {}

for _, v in ipairs({ "clangd", "ghdl_ls", "lua_ls", "basedpyright", "rust_analyzer", "typos_lsp", "vtsls", "ltex" }) do
    M[v] = require("lsp.config." .. v)
end

return M
