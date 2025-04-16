---@type LazySpec
return {
    {
        "folke/snacks.nvim",
        opts = {
            -- customize dashboard options
            dashboard = {
                width = 40,
                preset = {
                    header = table.concat({
                        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                    }, "\n"),
                },
            },
            indent = {
                indent = { char = "▎" },
                scope = {
                    char = "▎",
                    underline = true,
                    hl = { "Delimiter1", "Delimiter2", "Delimiter3" },
                },
            },
            notifier = { timeout = 5000 },
        },
    },
    -- You can disable default plugins as follows:
    -- { "max397574/better-escape.nvim", enabled = false },
    --
    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            local filetype_functions = require("luasnip.extras.filetype_functions")
            opts.ft_func = filetype_functions.from_pos_or_filetype
            opts.load_ft_func = filetype_functions.extend_load_ft({
                markdown = { "latex" },
                norg = { "norg_meta", "latex" },
                tex = { "latex" },
            })
            opts.enable_autosnippets = true
            opts.store_selection_keys = "<C-w>"
        end,
        config = function(plugin, opts)
            local luasnip = require("luasnip")
            require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
            luasnip.filetype_extend("markdown_inline", { "markdown" })
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            ---@diagnostic disable-next-line: assign-type-mismatch Luasnip accepts a single string
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })

            -- Remove unused friendly-snippets snippets
            luasnip.available(function(snippet)
                local names = { "copyright", "dateMDY", "Lorem Ipsum Paragraph", "Lorem Ipsum Sentence" }
                return vim.list_contains(names, snippet.name) and snippet:invalidate()
            end)
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
    {
        "folke/which-key.nvim",
        -- config = function(plugin, opts)
        --   require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
        --   -- Add bindings which show up as group name
        --   local wk = require "which-key"
        --   wk.add({
        --     b = { name = "Buffer" },
        --   }, { mode = "n", prefix = "<leader>" })
        -- end,
        opts = {
            -- stylua: ignore
            spec = {
                { "<Leader>",      group = "User mappings",          mode = { "n", "i", "x", "s", "o", "t", "c" } },
                { "<LocalLeader>", group = "User mappings (Buffer)", mode = { "n", "i", "x", "s", "o", "t", "c" } },
                -- Fast movement
                { "J",             "5j",                             desc = "Fast downwards movement",            mode = { "n", "v" } },
                { "K",             "5k",                             desc = "Fast upwards movement",              mode = { "n", "v" } },
                -- Disable keys
                { "<Left>",        "<nop>",                          mode = { "n", "v", "i" } },
                { "<Right>",       "<nop>",                          mode = { "n", "v", "i" } },
                { "<Up>",          "<nop>",                          mode = { "n", "v", "i" } },
                { "<Down>",        "<nop>",                          mode = { "n", "v", "i" } },
                { "<Insert>",      "<nop>",                          mode = { "n", "v", "i" } },
                { "<Home>",        "<nop>",                          mode = { "n", "v", "i" } },
                { "<End>",         "<nop>",                          mode = { "n", "v", "i" } },
                { "<PageUp>",      "<nop>",                          mode = { "n", "v", "i" } },
                { "<PageDown>",    "<nop>",                          mode = { "n", "v", "i" } },
                { "<F1>",          "<nop>",                          mode = { "n", "v", "i" } },
            },
            icons = {
                keys = {
                    Up = " ",
                    Down = " ",
                    Left = " ",
                    Right = " ",
                    C = "C-",
                    M = "A-",
                    BS = "󰁮 ",
                },
            },
        },
    },
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
        "Saghen/blink.cmp",
        specs = { "xzbdmw/colorful-menu.nvim" },
        opts = {
            completion = {
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                                    -- Don't use colorful-menu.nvim for lua_ls, since LSP highlights better function arguments
                                    if client and not client:is_stopped() and client.name ~= "lua_ls" then
                                        return require("colorful-menu").blink_components_highlight(ctx)
                                    end
                                    local draw = require("blink.cmp.config.completion.menu").default.draw
                                    return draw.components.label.highlight(ctx, "")
                                end,
                            },
                        },
                    },
                },
            },
            sources = {
                providers = {
                    path = { opts = { ignore_root_slash = true } },
                    snippets = { opts = { show_autosnippets = true } },
                },
            },
            cmdline = { completion = { ghost_text = { enabled = true } } },
        },
    },
    {
        "folke/todo-comments.nvim",
        keys = { { "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Find TODOs" } },
    },
    {
        "echasnovski/mini.icons",
        opts = function(_, opts)
            opts.lsp = require("icons").lsp
        end,
    },
    -- TODO: actually replace with mini.icons?
    -- {
    --     "nvim-tree/nvim-web-devicons",
    --     opts = function(_, opts)
    --         local utils = require("astroui")
    --         local vscode = require("highlights.vscode")
    --         require("nvim-web-devicons").set_icon_by_filetype({
    --             toggleterm = "terminal",
    --             latex = "tex",
    --             mason = "lsp",
    --             cargo = "rs",
    --         })
    --         local md = {
    --             icon = "",
    --             color = "#519aba",
    --             name = "Markdown",
    --         }
    --         local readme = {
    --             icon = "󰂾",
    --             color = "#519aba",
    --             cterm_color = "255",
    --             name = "Readme",
    --         }
    --         return vim.tbl_deep_extend("force", opts, {
    --             override = {
    --                 markdown = md,
    --                 md = md,
    --                 ["neo-tree"] = {
    --                     icon = utils.get_icon("FolderClosed"),
    --                     color = utils.get_hlgroup("Directory").fg,
    --                     name = "NeoTree",
    --                 },
    --                 telescopeprompt = {
    --                     icon = utils.get_icon("Search"),
    --                     name = "Telescope",
    --                 },
    --                 lazy = {
    --                     icon = "󰒲",
    --                     color = vscode.LazyH1.bg,
    --                     name = "Lazy",
    --                 },
    --                 ["null-ls-info"] = {
    --                     icon = utils.get_icon("ActiveLSP"),
    --                     color = vscode.LazyH1.bg,
    --                     name = "Null-LS-Info",
    --                 },
    --                 alpha = {
    --                     icon = "α",
    --                     color = vscode.LazyH1.bg,
    --                     name = "Alpha",
    --                 },
    --                 ["readme"] = readme,
    --                 ["readme.md"] = readme,
    --             },
    --         })
    --     end,
    -- },
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
    { "JoosepAlviste/nvim-ts-context-commentstring", event = "User AstroFile" },
    { "folke/lazydev.nvim", opts = { library = { "nvim-dap-ui" } } },
}
