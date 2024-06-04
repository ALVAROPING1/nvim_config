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
                norg = { "norg_meta", "latex" },
            }),
            enable_autosnippets = true,
            store_selection_keys = "<C-w>",
        },
        config = function(plugin, opts)
            require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
            require("luasnip").filetype_extend("markdown_inline", { "markdown" })
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            ---@diagnostic disable-next-line: assign-type-mismatch Luasnip accepts a single string
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
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
                if entry.source.name == "path" then
                    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                    if icon then
                        vim_item.kind = icon
                        vim_item.kind_hl_group = hl_group
                        return vim_item
                    end
                end
                return require("lspkind").cmp_format(require("astrocore").plugin_opts("lspkind.nvim"))(entry, vim_item)
            end

            opts.sources = cmp.config.sources(opts.sources, { { name = "neorg" } })
            return opts
        end,
    },
    { "rcarriga/nvim-notify", opts = { icons = { INFO = "" } } },
    {
        "folke/todo-comments.nvim",
        keys = { { "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Find TODOs" } },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            -- TODO: move underline position in Kitty once an updated version is on the package repos
            debounce = 500,
            indent = { char = "▎" },
            scope = {
                include = {
                    node_type = {
                        lua = { "table_constructor", "function_call" },
                        python = { "argument_list", "list", "tuple", "set", "dictionary", "generator_expression" },
                        ["*"] = { "parameters" },
                    },
                },
            },
        },
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = function(_, opts)
            local utils = require("astroui")
            local vscode = require("highlights.vscode")
            require("nvim-web-devicons").set_icon_by_filetype({
                toggleterm = "terminal",
                latex = "tex",
                mason = "lsp",
                lspinfo = "lsp",
                ["null-ls-info"] = "lsp",
                cargo = "rs",
            })
            local md = {
                icon = "",
                color = "#519aba",
                name = "Markdown",
            }
            return vim.tbl_deep_extend("force", opts, {
                override = {
                    markdown = md,
                    md = md,
                    ["neo-tree"] = {
                        icon = utils.get_icon("FolderClosed"),
                        color = utils.get_hlgroup("Directory").fg,
                        name = "NeoTree",
                    },
                    telescopeprompt = {
                        icon = utils.get_icon("Search"),
                        name = "Telescope",
                    },
                    lazy = {
                        icon = "󰒲",
                        color = vscode.LazyH1.bg,
                        name = "Lazy",
                    },
                    lsp = {
                        icon = utils.get_icon("ActiveLSP"),
                        color = vscode.LazyH1.bg,
                        name = "LSPInfo",
                    },
                    alpha = {
                        icon = "α",
                        color = vscode.LazyH1.bg,
                        name = "Alpha",
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 250,
                ignore_whitespace = true,
                virt_text_priority = 5000,
            },
            current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>",
        },
    },
}
