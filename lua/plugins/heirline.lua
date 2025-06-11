---@type LazySpec
return {
    "rebelot/heirline.nvim",
    specs = {
        {
            "AstroNvim/astroui",
            config = function(_, opts)
                require("astroui").setup(opts)
                local status = require("astroui.status")

                --- Gets the filename of the buffer. Falls back to the filetype if it has no name
                ---@param bufnr integer Buffer number
                ---@param type 0 | 2 Whether to get the icon name (0) or filetype (2)
                ---@return string
                local function get_file_text(bufnr, type)
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    local filename = vim.fn.fnamemodify(bufname, ":t")
                    local filetype = vim.bo[bufnr].filetype
                    local term_app = bufname:match("^term://.*:(.-)%s*;#toggleterm#%d*$")
                    local cargo_app = filename:match("^.+&& (cargo %w+)")
                    -- stylua: ignore
                    ---@format disable-next
                    return (
                        -- Toggleterm buffers
                        (term_app and type == 2 and term_app:sub(1, 1) == "/" and vim.fn.fnamemodify(term_app, ":t"))
                        -- Cargo (Rust) buffers
                        or (cargo_app and (type == 0 and "cargo" or cargo_app))
                        -- Diffview buffers
                        or (filetype:match("^Diffview") and type == 0 and "git")
                        -- Snacks.picker buffers
                        or (filetype:match("^snacks_picker") and type == 0 and "snacks_picker")
                        -- Fallback
                        or filetype
                    )
                end

                --- Gets the icon of the buffer
                ---@param bufnr integer Buffer number
                ---@return string Character
                ---@return string? Color
                ---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add more icons
                function status.utils.icon_provider(bufnr)
                    local icon, hl = require("mini.icons").get("filetype", get_file_text(bufnr, 0))
                    local color = require("astroui").get_hlgroup(hl).fg
                    if type(color) == "number" then
                        color = string.format("#%06x", color)
                    end
                    return icon, color
                end

                ---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add names based on filenames in some cases
                function status.provider.filetype(opt)
                    return function(self)
                        return status.utils.stylize(get_file_text(self and self.bufnr or 0, 2), opt)
                    end
                end
            end,
        },
    },
    opts = function(_, opts)
        local status = require("astroui.status")
        local hl = require("astroui.status.hl")
        -- NVChad statusline
        opts.statusline = {
            -- default highlight for the entire statusline
            hl = { fg = "fg", bg = "bg" },
            -- each element following is a component in astroui.status module

            -- add the vim mode component
            status.component.mode({
                -- enable mode text with padding as well as an icon before it
                mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
                -- surround the component with a separators
                surround = {
                    -- it's a left element, so use the left separator
                    separator = "left",
                    -- set the color of the surrounding based on the current mode using astroui.status module
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
            -- add a section for the currently opened filetype information
            status.component.file_info({
                -- enable the file_icon and disable the highlighting based on filetype
                file_icon = { padding = { left = 0, right = 0 }, condition = false },
                filetype = { padding = { left = 1 } },
                -- disable all other elements of the file_info component
                filename = false,
                file_modified = false,
                file_read_only = false,
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
            -- fill the rest of the statusline
            -- the elements after this will appear on the right of the statusline
            status.component.fill(),
            -- add a component for the current diagnostics if it exists and use the right separator for the section
            status.component.diagnostics({ surround = { separator = "right" }, padding = { right = 1 } }),
            -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
            status.component.lsp({
                lsp_progress = false,
                padding = { right = 1 },
                surround = { separator = "right" },
            }),
            -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
            -- all of the children of this table will be treated together as a single component
            {
                -- define a simple component where the provider is just a folder icon
                status.component.builder({
                    -- astrocore.get_icon gets the user interface icon for a closed folder with a space after it
                    { provider = require("astroui").get_icon("FolderClosed") },
                    -- add padding after icon
                    padding = { right = 1 },
                    -- set the foreground color to be used for the icon
                    hl = function()
                        return hl.get_attributes("folder_icon")
                    end,
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
                    filetype = false,
                    file_icon = false,
                    file_modified = false,
                    file_read_only = false,
                    -- use no separator for this part but define a background color
                    surround = { separator = "none", color = "folder_bg", condition = false },
                    hl = function()
                        return hl.get_attributes("folder", true)
                    end,
                }),
            },
            -- the final component of the NvChad statusline is the navigation section
            -- this is very similar to the previous current working directory section with the icon
            { -- make nav section with icon border
                -- define a custom component with just a file icon
                status.component.builder({
                    { provider = require("astroui").get_icon("ScrollText") },
                    -- add padding after icon
                    padding = { right = 1 },
                    -- set the icon foreground
                    hl = function()
                        return hl.get_attributes("nav_icon")
                    end,
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
