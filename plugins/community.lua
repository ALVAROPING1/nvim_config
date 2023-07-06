return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of importing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    { import = "astrocommunity.editing-support.nvim-ts-rainbow2" },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            rainbow = {
                disable = { "markdown" },
                querry = {
                    "rainbow-parens",
                    latex = "rainbow-blocks",
                },
                hlgroups = {
                    "Parens1",
                    "Parens2",
                    "Parens3",
                },
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
    -- { import = "astrocommunity.test.neotest" },
    {
        "nvim-neotest/neotest",
        config = function()
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
            require("neotest").setup({
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
            })
        end,
        ft = {
            "python",
            "rust",
        },
        dependencies = {
            "nvim-neotest/neotest-python",
            "rouge8/neotest-rust",
        },
    },
    { import = "astrocommunity.editing-support.treesj" },
    {
        "Wansmer/treesj",
        keys = { { "<leader>J", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" } },
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
        keys = {
            {
                "<leader>lr",
                function()
                    require("inc_rename")
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end,
                expr = true,
                desc = "Rename current symbol",
            },
        },
    },
    { import = "astrocommunity.project.nvim-spectre" },
    {
        "nvim-pack/nvim-spectre",
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
            vim.list_extend(opts.disabled_filetypes, { "neotest-summary" })
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
            },
            presets = {
                inc_rename = true,
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
}
