return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of importing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    {
        "danymat/neogen",
        opts = {
            languages = {
                lua = { template = { annotation_convention = "emmylua" } },
                python = { template = { annotation_convention = "numpydoc" } },
            },
        },
    },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    { import = "astrocommunity.editing-support.nvim-ts-rainbow2" },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            rainbow = {
                enable = true,
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
                --   find = "%$.*%$",
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
    { "linux-cultist/venv-selector.nvim",              enabled = false },
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
                -- your neotest config here
                adapters = {
                    require("neotest-python"),
                    -- require "neotest-rust",
                },
            })
        end,
        ft = { --[["rust",]]
            "python",
        },
        dependencies = {
            "nvim-neotest/neotest-python",
            -- "rouge8/neotest-rust",
        },
    },
    { import = "astrocommunity.editing-support.treej" },
    {
        "Wansmer/treesj",
        keys = { { "<leader>J", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" } },
        opts = {
            max_join_length = 100,
        },
    },
    { import = "astrocommunity.git.git-blame-nvim" },
    { import = "astrocommunity.lsp.inc-rename" },
    {
        "smjonas/inc-rename.nvim",
        opts = {
            hlgroup = "IncRenameText",
        },
    },
    { import = "astrocommunity.project.neoconf-nvim" },
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
}
