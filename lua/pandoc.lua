local M = {}

local NOTIFY_OPTS = { title = "Pandoc" }

--- Replaces the extension of the file name
---@param filename string Original filename
---@param extension string New extension
---@return string
local function change_extension(filename, extension)
    return vim.fn.fnamemodify(filename, ":r") .. extension
end

--- Creates the `pandoc` arguments table
---@param input_file string input file to convert
---@return string[]
local function get_cmd(input_file)
    local output_file = change_extension(input_file, ".pdf")
    local Path = require("plenary.path")
    local has_data_dir = Path:new(".pandoc"):is_dir()
    local has_options_file = has_data_dir or Path:new("pandoc_options.yaml"):is_file()

    -- stylua: ignore
    return vim.tbl_filter(function(x) return x ~= nil end, {
        "pandoc",
        input_file,
        "-o",
        output_file,
        has_data_dir and "--data-dir=.pandoc" or nil,
        has_options_file and "--defaults=pandoc_options.yaml" or nil,
    })
end

--- Exports a given file to PDF
---@param file string File path
---@param cleanup fun()? Cleanup function to call after `pandoc` finishes running
local function export_file(file, cleanup)
    local cmd = get_cmd(file)
    local output_file = cmd[4]

    ---@param out vim.SystemCompleted
    vim.system(cmd, { text = true }, function(out)
        if cleanup then
            cleanup()
        end
        if out.code ~= 0 then
            vim.notify(out.stderr:sub(1, -3), vim.log.levels.ERROR, NOTIFY_OPTS)
            return
        end
        vim.notify("PDF Exported", vim.log.levels.INFO, NOTIFY_OPTS)
        vim.system({ "xdg-open", output_file })
    end)
    vim.notify("Exporting PDF...", vim.log.levels.INFO, NOTIFY_OPTS)
end

--- Table of functions to convert each supported filetype
local CONVERSION_FUNCTION = {
    markdown = export_file,
    norg = function(filename)
        local content, _ = require("neorg.core.modules").get_module("core.export").export(0, "markdown")
        content = content:gsub("(\n%s*%d+)%. ", "%1%) ")
        local file = require("plenary.path"):new(change_extension(filename, ".md"))
        file:write(content, "w")
        export_file(file.filename, function()
            file:rm()
        end)
    end,
}

--- Exports the current buffer to PDF
function M.export()
    local ft = vim.bo.filetype
    local converter = CONVERSION_FUNCTION[ft]
    if converter == nil then
        vim.notify(string.format("Error: Unknown filetype `%s`", ft), vim.log.levels.ERROR, NOTIFY_OPTS)
        return
    end

    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        vim.notify("Error: Buffer must be in the disk", vim.log.levels.ERROR, NOTIFY_OPTS)
        return
    end
    vim.cmd("silent! write")
    converter(file)
end

return M
