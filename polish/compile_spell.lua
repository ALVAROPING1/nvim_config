-- Compile spell word dictionaries on startup
local paths = vim.split(vim.fn.glob(vim.env.XDG_CONFIG_HOME .. "/nvim/lua/user/spell/*.add"), '\n')
for _, file in pairs(paths) do
    vim.cmd('silent mkspell! ' .. file)
end
