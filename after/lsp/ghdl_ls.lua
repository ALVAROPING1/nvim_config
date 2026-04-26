-- Config for the ghdl-ls (VHDL) language server
---@type vim.lsp.Config
return { cmd = { vim.fs.normalize("~/.local/opt/ghdl/venv/bin/ghdl-ls") } }
