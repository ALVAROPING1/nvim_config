return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of importing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    {
        "bennypowers/nvim-regexplainer",
        ft = { "python" },
        opts = {
            auto = true,
            filetypes = { "py" },
        },
    },
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        opts = {
            blacklist = { "markdown" },
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            },
            highlight = {
                "Parens1",
                "Parens2",
                "Parens3",
            },
        },
    },
    { import = "astrocommunity.editing-support.todo-comments-nvim" },
    { import = "astrocommunity.terminal-integration.flatten-nvim" },
    { import = "astrocommunity.utility.neodim" },
    {
        "zbirenbaum/neodim",
        commit = "ba5dfa8",
        opts = {
            alpha = 0.667,
            hide = {
                virtual_text = false,
                signs = false,
                underline = false,
            },
        },
    },
    { import = "astrocommunity.motion.nvim-surround" },
    {
        "kylechui/nvim-surround",
        opts = {
            keymaps = {
                insert = "<C-s>",
                insert_line = "<C-s>g",
                normal = "<C-s>a",
                normal_cur = "<C-s>aa",
                normal_line = "<C-s>A",
                normal_cur_line = "<C-s>AA",
                visual = "<C-s>",
                visual_line = "<C-s>g",
                delete = "<C-s>d",
                change = "<C-s>c",
            },
            surrounds = {
                -- ["$"] = {
                --   add = { "$", "$" },
                --   find = "%$.-%$",
                --   delete = "(%$)().*(%$)()",
                -- },
            },
            aliases = {
                ["p"] = ")",
                ["b"] = "}",
                ["c"] = "]",
                ["B"] = false,
                ["r"] = false,
                ["m"] = "$",
                ["M"] = "$$",
            },
            move_cursor = false,
        },
    },
    { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },
    { import = "astrocommunity.scrolling.cinnamon-nvim" },
    {
        "declancm/cinnamon.nvim",
        opts = { default_delay = 5 },
    },
    { import = "astrocommunity.scrolling.satellite-nvim" },
    { "lewis6991/satellite.nvim",                            commit = "f36c6ff" }, -- Newer versions require neovim 0.10
    -- { import = "astrocommunity.indent.mini-indentscope" },
    -- {
    --   'echasnovski/mini.indentscope',
    --   opts = {
    --     symbol = "▏"
    --   }
    -- },
    { import = "astrocommunity.indent.indent-blankline-nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            char = "▏",
            -- context_char = "│",
            context_highlight_list = {
                "Parens1",
                "Parens2",
                "Parens3",
            },
            use_treesitter = true,
            -- use_treesitter_scope = true,
            max_indent_increase = 1,
            show_current_context = true,
            show_current_context_start = true,
            context_patterns = {
                "class",
                "func",
                "method",
                "if",
                "while",
                "for",
                "with",
                "try",
                "except",
                "arguments",
                "argument_list",
                "object",
                "dictionary",
                "element",
                "table",
                "tuple",
                "do_block",
            },
        },
    },
    { import = "astrocommunity.scrolling.mini-animate" },
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function()
            local animate = require("mini.animate")
            return {
                resize = {
                    timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
                },
                scroll = {
                    enable = false,
                },
                cursor = {
                    timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
                },
            }
        end,
        config = function(_, opts)
            require("mini.animate").setup(opts)
        end,
    },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.rust" },
    { "simrat39/rust-tools.nvim",                      opts = { server = { standalone = true } } },
    { "linux-cultist/venv-selector.nvim",              enabled = false },
    {
        "mfussenegger/nvim-dap-python",
        opts = { pythonPath = require("user.utils").python.get_path(vim.loop.cwd()) },
        config = function(_, opts)
            local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
            require("dap-python").setup(path, opts)

            -- Make python debugger use the current working directory instead of the file path
            for _, config in ipairs(require("dap").configurations.python) do
                config.cwd = vim.loop.cwd()
            end
        end,
    },
    {
        "Civitasv/cmake-tools.nvim",
        opts = {
            cmake_build_directory = "build/${variant:buildType}",
            cmake_soft_link_compile_commands = false,
            cmake_compile_commands_from_lsp = true,
        },
    },
    -- { import = "astrocommunity.test.neotest" },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
        },
        keys = {
            { "<leader>dt", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle tests summary window" },
        },
        opts = function()
            return {
                adapters = {
                    require("neotest-python"),
                    require("neotest-rust"),
                },
                quickfix = { enabled = false },
                summary = {
                    mappings = {
                        next_failed = "l",
                        prev_failed = "h",
                    },
                },
            }
        end,
        config = function(_, opts)
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup(opts)
        end,
    },
    { import = "astrocommunity.editing-support.treesj" },
    {
        "Wansmer/treesj",
        keys = function(_, keys)
            keys[1][1] = "<leader>J"
        end,
        opts = {
            max_join_length = 100,
        },
    },
    { import = "astrocommunity.git.git-blame-nvim" },
    { import = "astrocommunity.lsp.inc-rename-nvim" },
    {
        "smjonas/inc-rename.nvim",
        opts = {
            hlgroup = "IncRenameText",
        },
        keys = function(_, keys)
            keys[1].desc = "Rename current symbol"
        end,
    },
    { import = "astrocommunity.project.nvim-spectre" },
    {
        "nvim-pack/nvim-spectre",
        keys = function(_, keys)
            local prefix = "<leader>s"
            local nprefix = "<leader>" .. prefix
            local maps = { n = {}, x = {} }

            local icon = vim.g.icons_enabled and "󰛔 " or ""
            maps.n[nprefix] = { desc = icon .. "Search / Replace" }
            maps.x[prefix] = { desc = icon .. "Search / Replace" }

            require("astronvim.utils").set_mappings(maps)
            for _, mapping in pairs(keys) do
                mapping[1] = mapping.mode == "x" and prefix or nprefix .. mapping[1]:sub(-1)
            end
        end,
        opts = {
            highlight = {
                search = "DiffDelete",
                replace = "DiffAdd",
            },
        },
    },
    { import = "astrocommunity.workflow.hardtime-nvim" },
    {
        "m4xshen/hardtime.nvim",
        opts = function(_, opts)
            opts.disabled_filetypes = { "cmake_tools_terminal" }
        end,
    },
    { import = "astrocommunity.utility.noice-nvim" },
    {
        "folke/noice.nvim",
        opts = {
            cmdline = {
                format = {
                    filter = { title = " Bash " },
                },
            },
            messages = { view_search = false },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "^/",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "escritos",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        any = {
                            { find = "Starting watcher for" },
                            { find = "Watcher running for " },
                            { find = "Stopping watch for " },
                        },
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "notify",
                        any = {
                            { find = "no parser for 'TelescopePrompt' language, see :help treesitter%-parsers" },
                            { find = "no parser for 'toggleterm' language, see :help treesitter%-parsers" },
                            { find = "no parser for 'DiffviewFileHistory' language, see :help treesitter%-parsers" },
                            { find = "no parser for 'DiffviewFiles' language, see :help treesitter%-parsers" },
                        },
                    },
                    opts = { skip = true },
                },
            },
            presets = {
                lsp_doc_border = true,
            },
        },
    },
    { import = "astrocommunity.motion.leap-nvim" },
    { import = "astrocommunity.motion.flit-nvim" },
    { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_lines = function(_, bufnr)
                    return not vim.tbl_contains(vim.g.lsp_lines, vim.bo[bufnr].ft) and { only_current_line = true }
                        or false
                end,
            })
        end,
    },
    { import = "astrocommunity.editing-support.dial-nvim" },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal_int,
                    augend.integer.new({
                        radix = 16,
                        prefix = "0x",
                        natural = true,
                        case = "upper",
                    }),
                    augend.integer.alias.binary,
                    augend.date.alias["%Y/%m/%d"],
                    augend.constant.new({ elements = { "true", "false" }, preserve_case = true }),
                    augend.constant.new({ elements = { "and", "or" } }),
                    augend.constant.new({ elements = { "&&", "||" }, word = false }),
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.semver.alias.semver,
                    augend.case.new({ types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" } }),
                },
            })
        end,
    },
    { import = "astrocommunity.editing-support.vim-move" },
    { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
            commented = false,
            highlight_new_as_changed = true,
        },
    },
    { import = "astrocommunity.editing-support.comment-box-nvim" },
    {
        "LudoPinelli/comment-box.nvim",
        opts = {
            box_width = 80,
            line_width = 80,
            outer_blank_lines = true,
            line_blank_line_above = true,
            line_blank_line_below = true,
        },
    },
    { import = "astrocommunity.utility.telescope-fzy-native-nvim" },
    { import = "astrocommunity.editing-support.multicursors-nvim" },
    {
        "smoka7/multicursors.nvim",
        config = function(_, opts)
            require("multicursors").setup(opts)
            -- HACK: The multicursors plugin always overrides them, so they have to be configured after the plugin is set up
            vim.api.nvim_set_hl(0, "MultiCursor", { link = "Visual" })
            vim.api.nvim_set_hl(0, "MultiCursorMain", { link = "Visual" })
        end,
        keys = function(_, keys)
            keys[1].desc = "Multiselect word under cursor"
        end,
    },
    { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
    { import = "astrocommunity.project.projectmgr-nvim" },
    {
        "charludo/projectmgr.nvim",
        opts = {
            autogit = { enabled = false }, -- Bugs out when using ssh authentication
            session = { enabled = false },
        },
    },
    { import = "astrocommunity.editing-support.refactoring-nvim" },
    {
        "ThePrimeagen/refactoring.nvim",
        opts = function()
            local mods = vim.loop.cwd():match("Trailmakers/mods$")
            local fn_print = mods and "tm.os.Log(%s)" or "print(%s)"
            local fn_tostring = mods and "tostring(%s)" or "vim.inspect(%s)"
            return {
                printf_statements = { lua = { fn_print:format('"Reached %s"') } },
                print_var_statements = { lua = { fn_print:format('"Variable %s " .. ' .. fn_tostring) } },
            }
        end,
    },
    { import = "astrocommunity.motion.nvim-spider" },
    { import = "astrocommunity.motion.vim-matchup" },
    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
            vim.g.matchup_matchparen_offscreen = {}
        end,
    },
}
