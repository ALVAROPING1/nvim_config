-- Compile spell word dictionaries on startup
local paths = vim.split(vim.fn.glob(".spell/*.add"), "\n")
if paths[1] ~= "" then
    for _, file in pairs(paths) do
        vim.cmd("silent mkspell! " .. file)
    end
end
