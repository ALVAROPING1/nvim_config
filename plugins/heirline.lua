local status = require("astronvim.utils.status")
local hl = require("astronvim.utils.status.hl")

--- Gets the filename of the buffer. Falls back to the filetype if it has no name
---@param bufnr integer Buffer number
---@param icon_name boolean Whether to get the icon name
---@param modify string Modifier of `vim.fn.fnamemodify()`
---@return string
function status.utils.get_filename(bufnr, icon_name, modify)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), modify)
    local filetype = vim.bo[bufnr].filetype
    local term_app = filename:match("^%d*:?(.-)%s*;#toggleterm#")
    local cargo_app = filename:match("^.+&& (cargo %w+)")
    return (
        -- Toggleterm buffers
           term_app
        -- Cargo (Rust) buffers
        or (cargo_app and (icon_name and "cargo" or cargo_app))
        -- Neo-tree buffer
        or (filename == "neo-tree filesystem [1]" and "Neo-tree")
        -- Plugins with floating window UI
        or (vim.tbl_contains({ "TelescopePrompt", "lazy", "mason", "lspinfo", "null-ls-info" }, filetype) and filetype:gsub("^%a", string.upper))
        -- Diffview buffers
        or (filename:match("^Diffview") and icon_name and "git")
        -- Fallback
        or filename
    )
end

--- Gets the icon of the buffer
---@param bufnr integer Buffer number
---@return string Character
---@return string? Color
function status.utils.get_file_icon(bufnr)
    local devicons_avail, devicons = pcall(require, "nvim-web-devicons")
    if not devicons_avail then
        return "", nil
    end
    local ft_icon, ft_color = devicons.get_icon_color(status.utils.get_filename(bufnr, true, ":t"))
    if not ft_icon then
        ft_icon, ft_color = devicons.get_icon_color_by_filetype(vim.bo[bufnr].filetype, { default = true })
    end
    return ft_icon, ft_color
end

---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to fix colors on buffers with filetype but no name
function hl.filetype_color(self)
    local _, color = status.utils.get_file_icon(self and self.bufnr or 0)
    return { fg = color }
end

---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add more icons
function status.provider.file_icon(opts)
    return function(self)
        local ft_icon, _ = status.utils.get_file_icon(self and self.bufnr or 0)
        return status.utils.stylize(ft_icon, opts)
    end
end

---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add names based on filetype in some cases
function status.provider.filename(opts)
    opts = require("astronvim.utils").extend_tbl({
        fallback = "Untitled",
        fname = function(nr)
            return status.utils.get_filename(nr, false, opts.modify)
        end,
        modify = ":t",
    }, opts)
    return function(self)
        local filename = opts.fname(self and self.bufnr or 0)
        return status.utils.stylize((filename == "" and opts.fallback or filename), opts)
    end
end

return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        -- Fix winbar icons losing color when the window is inactive
        -- Modified from: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/bars-and-lines/heirline-vscode-winbar/init.lua
        opts.winbar[1][2] = status.component.file_info({
            file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = status.hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
        })
        -- NVChad statusline
        opts.statusline = {
            -- default highlight for the entire statusline
            hl = { fg = "fg", bg = "bg" },
            -- each element following is a component in astronvim.utils.status module

            -- add the vim mode component
            status.component.mode({
                -- enable mode text with padding as well as an icon before it
                mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
                -- surround the component with a separators
                surround = {
                    -- it's a left element, so use the left separator
                    separator = "left",
                    -- set the color of the surrounding based on the current mode using astronvim.utils.status module
                    color = function()
                        return { main = status.hl.mode_bg(), right = "blank_bg" }
                    end,
                },
            }),
            -- we want an empty space here so we can use the component builder to make a new section with just an empty string
            status.component.builder({
                { provider = "" },
                -- define the surrounding separator and colors to be used inside of the component
                -- and the color to the right of the separated out section
                surround = { separator = "left", color = { main = "blank_bg", right = "file_info_bg" } },
            }),
            -- add a section for the currently opened file information
            status.component.file_info({
                -- enable the file_icon and disable the highlighting based on filetype
                file_icon = { padding = { left = 0 } },
                -- add padding
                padding = { right = 1 },
                -- define the section separator
                surround = { separator = "left", condition = false },
            }),
            -- add a component for the current git branch if it exists and use no separator for the sections
            status.component.git_branch({ padding = { right = 1 }, surround = { separator = "none" } }),
            -- add a component for the current git diff if it exists and use no separator for the sections
            status.component.git_diff({ surround = { separator = "none" } }),
            -- fill the rest of the statusline
            -- the elements after this will appear in the middle of the statusline
            status.component.fill(),
            -- add a componen for the cmdline (search count/macro recording)
            status.component.cmd_info(),
            -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
            status.component.lsp({
                lsp_client_names = false,
                hl = hl.get_attributes("lsp_progress"),
                surround = { separator = "none", color = "bg" },
            }),
            -- fill the rest of the statusline
            -- the elements after this will appear on the right of the statusline
            status.component.fill(),
            -- add a component for the current diagnostics if it exists and use the right separator for the section
            status.component.diagnostics({ surround = { separator = "right" }, padding = { right = 1 } }),
            -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
            status.component.lsp({
                lsp_progress = false,
                hl = hl.get_attributes("lsp_clients"),
                padding = { right = 1 },
                surround = { separator = "right" },
            }),
            -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
            -- all of the children of this table will be treated together as a single component
            {
                -- define a simple component where the provider is just a folder icon
                status.component.builder({
                    -- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
                    { provider = require("astronvim.utils").get_icon("FolderClosed") },
                    -- add padding after icon
                    padding = { right = 1 },
                    -- set the foreground color to be used for the icon
                    hl = hl.get_attributes("folder_icon"),
                    -- use the right separator and define the background color
                    surround = { separator = "right", color = "folder_icon_bg" },
                }),
                -- add a file information component and only show the current working directory name
                status.component.file_info({
                    -- we only want filename to be used and we can change the fname
                    -- function to get the current working directory name
                    filename = {
                        fname = function(nr)
                            return vim.fn.fnamemodify(vim.fn.getcwd(nr), ":t")
                        end,
                        padding = { left = 1, right = 1 },
                    },
                    -- disable all other elements of the file_info component
                    file_icon = false,
                    file_modified = false,
                    file_read_only = false,
                    -- use no separator for this part but define a background color
                    surround = { separator = "none", color = "folder_bg", condition = false },
                    hl = hl.get_attributes("folder", true),
                }),
            },
            -- the final component of the NvChad statusline is the navigation section
            -- this is very similar to the previous current working directory section with the icon
            { -- make nav section with icon border
                -- define a custom component with just a file icon
                status.component.builder({
                    { provider = require("astronvim.utils").get_icon("ScrollText") },
                    -- add padding after icon
                    padding = { right = 1 },
                    -- set the icon foreground
                    hl = hl.get_attributes("nav_icon"),
                    -- use the right separator and define the background color
                    -- as well as the color to the left of the separator
                    surround = { separator = "right", color = { main = "nav_icon_bg", left = "folder_bg" } },
                }),
                -- add a navigation component and just display the percentage of progress in the file
                status.component.nav({
                    -- add some padding for the percentage provider
                    percentage = { padding = { right = 1 } },
                    -- add some padding for the ruler provider, and remove internal padding
                    ruler = { padding = { left = 1 }, pad_ruler = { line = 0, char = 0 } },
                    -- disable all other providers
                    scrollbar = false,
                    -- use no separator and define the background color
                    surround = { separator = "none", color = "nav_bg" },
                }),
            },
        }

        -- return the final options table
        return opts
    end,
}
