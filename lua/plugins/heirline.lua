---@type LazySpec
return {
    "rebelot/heirline.nvim",
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
                hl = hl.get_attributes("lsp_clients"),
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
                    filetype = false,
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
                    { provider = require("astroui").get_icon("ScrollText") },
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
    init = function()
        local status = require("astroui.status")

        --- Gets the filename of the buffer. Falls back to the filetype if it has no name
        ---@param bufnr integer Buffer number
        ---@param type 0 | 1 | 2 Whether to get the icon name (0), file name (1), or filetype (2)
        ---@param modify string? Modifier of `vim.fn.fnamemodify()`
        ---@return string
        ---@diagnostic disable-next-line: inject-field
        function status.utils.get_file_text(bufnr, type, modify)
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), modify or ":t")
            local filetype = vim.bo[bufnr].filetype
            local term_app = filename:match("^%d*:?(.-)%s*;#toggleterm#")
            local cargo_app = filename:match("^.+&& (cargo %w+)")
            return (
                -- Toggleterm buffers
                   term_app
                -- Cargo (Rust) buffers
                or (cargo_app and (type == 0 and "cargo" or cargo_app))
                -- Neo-tree buffer
                or (filename == "neo-tree filesystem [1]" and "Neo-tree")
                -- Plugins with floating window UI
                or (vim.list_contains({ "TelescopePrompt", "lazy", "mason", "null-ls-info" }, filetype) and filetype:gsub("^%a", string.upper))
                -- Diffview buffers
                or (filename:match("^Diffview") and type == 0 and "git")
                -- Fallback
                or (type == 1 and filename or filetype)
            )
        end

        --- Gets the icon of the buffer
        ---@param bufnr integer Buffer number
        ---@return string Character
        ---@return string? Color
        ---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add more icons
        function status.utils.icon_provider(bufnr)
            local devicons = require("nvim-web-devicons")
            local ft_icon, ft_color = devicons.get_icon_color(status.utils.get_file_text(bufnr, 0))
            if not ft_icon then
                ft_icon, ft_color = devicons.get_icon_color_by_filetype(vim.bo[bufnr].filetype, { default = true })
            end
            return ft_icon, ft_color
        end

        ---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add names based on filetype in some cases
        function status.provider.filename(opt)
            opt = require("astrocore").extend_tbl({
                fallback = "Untitled",
                fname = function(nr)
                    return status.utils.get_file_text(nr, 1, opt.modify)
                end,
                modify = ":t",
            }, opt)
            return function(self)
                local filename = opt.fname(self and self.bufnr or 0)
                return status.utils.stylize((filename == "" and opt.fallback or filename), opt)
            end
        end

        ---@diagnostic disable-next-line: duplicate-set-field # Function is intentionally overwritten to add names based on filenames in some cases
        function status.provider.filetype(opt)
            return function(_)
                return status.utils.stylize(status.utils.get_file_text(0, 2), opt)
            end
        end
    end,
}
