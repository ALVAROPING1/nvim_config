-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- Import/override with your plugins folder
    -- Available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    {
        "bennypowers/nvim-regexplainer",
        ft = { "python" },
        opts = {
            auto = true,
            filetypes = { "py" },
            popup = {
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
        },
    },
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        opts = function()
            return {
                strategy = {
                    [""] = require("rainbow-delimiters").strategy["global"],
                    norg = require("rainbow-delimiters").strategy["noop"],
                    markdown = require("rainbow-delimiters").strategy["noop"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    latex = "rainbow-blocks",
                },
                highlight = vim.g.rainbow_delimiters_highlight,
            }
        end,
    },
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
    { "lewis6991/satellite.nvim",                        commit = "f36c6ff" }, -- Newer versions require neovim 0.10
    { import = "astrocommunity.scrolling.mini-animate" },
    {
        "echasnovski/mini.animate",
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
    },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python-ruff" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.rust" },
    { "simrat39/rust-tools.nvim",                opts = { server = { standalone = true } } },
    { "linux-cultist/venv-selector.nvim",        enabled = false },
    {
        "mfussenegger/nvim-dap-python",
        opts = { pythonPath = require("python_utils").get_path(vim.loop.cwd()) },
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
            save_in_cmdline_history = false,
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

            require("astrocore").set_mappings(maps)
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
        opts = {
            disabled_filetypes = {
                -- Default (required since the option is overwritten rather than merged)
                "NvimTree",
                "TelescopePrompt",
                "aerial",
                "alpha",
                "checkhealth",
                "dapui-repl",
                "dapui_breakpoints",
                "dapui_console",
                "dapui_scopes",
                "dapui_stacks",
                "dapui_watches",
                "DressingInput",
                "DressingSelect",
                "help",
                "lazy",
                "mason",
                "neotest-summary",
                "neo-tree",
                "neo-tree-popup",
                "noice",
                "notify",
                "prompt",
                "qf",
                -- Custom
                "cmake_tools_terminal",
                "query",
            },
        },
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
                            { find = "Watcher running for" },
                            { find = "Stopping watch for" },
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
    -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim",     opts = {} },
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
            box_width = 78,
            line_width = 80,
            outer_blank_lines = true,
            line_blank_line_above = true,
            line_blank_line_below = true,
        },
    },
    { import = "astrocommunity.editing-support.multicursors-nvim" },
    {
        "smoka7/multicursors.nvim",
        event = false,
        keys = function(_, keys)
            keys[1].desc = "Multiselect word under cursor"
        end,
    },
    { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
    { import = "astrocommunity.project.projectmgr-nvim" },
    {
        "charludo/projectmgr.nvim",
        event = false,
        lazy = true,
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
    { import = "astrocommunity.git.diffview-nvim" },
}
