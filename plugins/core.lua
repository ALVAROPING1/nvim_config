return {
    -- customize alpha options
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- customize the dashboard header
            opts.section.header.val = {
                " █████  ███████ ████████ ██████   ██████",
                "██   ██ ██         ██    ██   ██ ██    ██",
                "███████ ███████    ██    ██████  ██    ██",
                "██   ██      ██    ██    ██   ██ ██    ██",
                "██   ██ ███████    ██    ██   ██  ██████",
                " ",
                "    ███    ██ ██    ██ ██ ███    ███",
                "    ████   ██ ██    ██ ██ ████  ████",
                "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "    ██   ████   ████   ██ ██      ██",
            }
            return opts
        end,
    },
    -- You can disable default plugins as follows:
    -- { "max397574/better-escape.nvim", enabled = false },
    --
    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        opts = {
            ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
            load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
                markdown = { "latex" },
            }),
            enable_autosnippets = true,
            store_selection_keys = "<C-w>",
        },
        config = function(plugin, opts)
            require("plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
            require("luasnip").filetype_extend("markdown_inline", { "markdown" })
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/user/snippets" })
        end,
    },
    -- {
    --   "windwp/nvim-autopairs",
    --   config = function(plugin, opts)
    --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
    --     -- add more custom autopairs configuration such as custom rules
    --     local npairs = require "nvim-autopairs"
    --     local Rule = require "nvim-autopairs.rule"
    --     local cond = require "nvim-autopairs.conds"
    --     npairs.add_rules(
    --       {
    --         Rule("$", "$", { "tex", "latex" })
    --           -- don't add a pair if the next character is %
    --           :with_pair(cond.not_after_regex "%%")
    --           -- don't add a pair if  the previous character is xxx
    --           :with_pair(
    --             cond.not_before_regex("xxx", 3)
    --           )
    --           -- don't move right when repeat character
    --           :with_move(cond.none())
    --           -- don't delete if the next character is xx
    --           :with_del(cond.not_after_regex "xx")
    --           -- disable adding a newline when you press <cr>
    --           :with_cr(cond.none()),
    --       },
    --       -- disable for .vim files, but it work for another filetypes
    --       Rule("a", "a", "-vim")
    --     )
    --   end,
    -- },
    -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
    -- {
    --   "folke/which-key.nvim",
    --   config = function(plugin, opts)
    --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
    --     -- Add bindings which show up as group name
    --     local wk = require "which-key"
    --     wk.register({
    --       b = { name = "Buffer" },
    --     }, { mode = "n", prefix = "<leader>" })
    --   end,
    -- },
    {
        "folke/neoconf.nvim",
        opts = {
            plugins = {
                lua_ls = {
                    enabled = true,
                },
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            -- opts parameter is the default options table
            -- the function is lazy loaded so cmp is able to be required
            local cmp = require("cmp")
            -- Floating window opts
            local border_opts = {
                border = "rounded",
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }
            opts.window = {
                completion = cmp.config.window.bordered(border_opts),
                documentation = cmp.config.window.bordered(border_opts),
            }
            -- Icon opts
            opts.formatting.expandable_indicator = false
            opts.formatting.format = function(entry, vim_item)
                if vim.tbl_contains({ "path" }, entry.source.name) then
                    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                    if icon then
                        vim_item.kind = icon
                        vim_item.kind_hl_group = hl_group
                        return vim_item
                    end
                end
                return require("lspkind").cmp_format(require("astronvim.utils").plugin_opts("lspkind.nvim"))(
                    entry,
                    vim_item
                )
            end

            return opts
        end,
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     opts = function(_, opts)
    --         opts.icons = require("user.icons").notify
    --         return opts
    --     end,
    -- },
    {
        "rebelot/heirline.nvim",
        opts = function(_, opts)
            local status = require("astronvim.utils.status")
            local hl = require("astronvim.utils.status.hl")
            opts.statusline = {
                -- NVChad statusline
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
                    filename = { fallback = "Untitled" },
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
                status.component.diagnostics({ surround = { separator = "right" } }),
                -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
                status.component.lsp({
                    lsp_progress = false,
                    hl = hl.get_attributes("lsp_clients"),
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
                                return vim.fn.getcwd(nr)
                            end,
                            padding = { left = 1 },
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
    },
}
