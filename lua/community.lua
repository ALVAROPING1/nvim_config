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
    {
        "folke/trouble.nvim",
        opts = function(_, opts)
            opts.modes = {
                todo = {
                    groups = {
                        { "tag",      format = " {todo_icon}{tag}" },
                        { "filename", format = "{file_icon} {filename} {count}" },
                    },
                },
            }
            opts.icons.folder_closed = " " .. opts.icons.folder_closed
            opts.icons.folder_open = " " .. opts.icons.folder_open
        end,
    },
    { import = "astrocommunity.editing-support.neogen" },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    {
        "bennypowers/nvim-regexplainer",
        ft = { "python", "javascript" },
        opts = {
            auto = true,
            filetypes = { "py", "js" },
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
        opts = function(_, opts)
            opts.strategy = {
                [""] = require("rainbow-delimiters").strategy["global"],
                norg = require("rainbow-delimiters").strategy["noop"],
                markdown = require("rainbow-delimiters").strategy["noop"],
            }
            opts.query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            }
            opts.highlight = { "Delimiter1", "Delimiter2", "Delimiter3" }
        end,
    },
    -- { import = "astrocommunity.terminal-integration.flatten-nvim" },
    -- { import = "astrocommunity.utility.neodim" },
    {
        -- TODO: switch back to "zbirenbaum/neodim" once #48 is merged
        "ALVAROPING1/neodim",
        branch = "fix-nvim-0.11",
        event = "LspAttach",
        opts = {
            alpha = 0.667,
            blend_color = "#000000",
            regex = { "[uU]nused", "[nN]ever [rR]ead", "[nN]ot [rR]ead", "[uU]nreachable" },
        },
    },
    { import = "astrocommunity.motion.nvim-surround" },
    {
        "kylechui/nvim-surround",
        ---@diagnostic disable-next-line: assign-type-mismatch -- Value does work
        event = false,
        keys = {
            { "gs",  "<Plug>(nvim-surround-normal)", desc = "Add surround pair around motion" },
            { "dgs", "<Plug>(nvim-surround-delete)", desc = "Delete surround pair" },
            { "cgs", "<Plug>(nvim-surround-change)", desc = "Change surround pair" },
            { "gs",  "<Plug>(nvim-surround-visual)", desc = "Add surround pair around selection", mode = "x" },
        },
        opts = {
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
            move_cursor = "sticky",
        },
    },
    { import = "astrocommunity.recipes.heirline-vscode-winbar" },
    { import = "astrocommunity.scrolling.satellite-nvim" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.python.basedpyright" },
    { import = "astrocommunity.pack.python.ruff" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.typst" },
    { "linux-cultist/venv-selector.nvim",        enabled = false },
    {
        "mfussenegger/nvim-dap-python",
        config = function(_, opts)
            opts.pythonPath = require("python_utils").get_path(vim.uv.cwd())
            local path = vim.fn.expand("$MASON/packages/debugpy") .. "/venv/bin/python"
            require("dap-python").setup(path, opts)

            -- Make python debugger use the current working directory instead of the file path
            for _, config in ipairs(require("dap").configurations.python) do
                config.cwd = vim.uv.cwd()
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
    { "mrcjkb/rustaceanvim",                 opts = { tools = { float_win_config = { border = "rounded" } } } },
    { import = "astrocommunity.test.neotest" },
    {
        "nvim-neotest/neotest",
        opts = {
            quickfix = { enabled = false },
            summary = { mappings = { next_failed = "l", prev_failed = "h" } },
        },
    },
    { import = "astrocommunity.editing-support.treesj" },
    { import = "astrocommunity.lsp.inc-rename-nvim" },
    {
        "smjonas/inc-rename.nvim",
        opts = { hlgroup = "IncRenameText", save_in_cmdline_history = false },
    },
    -- { import = "astrocommunity.project.nvim-spectre" },
    -- {
    --     "nvim-pack/nvim-spectre",
    --     keys = function(_, keys)
    --         local prefix = "<leader>s"
    --         local nprefix = "<leader>" .. prefix
    --         local maps = { n = {}, x = {} }
    --
    --         local icon = vim.g.icons_enabled and "󰛔 " or ""
    --         maps.n[nprefix] = { desc = icon .. "Search / Replace" }
    --         maps.x[prefix] = { desc = icon .. "Search / Replace" }
    --
    --         require("astrocore").set_mappings(maps)
    --         for _, mapping in pairs(keys) do
    --             mapping[1] = mapping.mode == "x" and prefix or nprefix .. mapping[1]:sub(-1)
    --         end
    --     end,
    --     opts = {
    --         highlight = {
    --             search = "DiffDelete",
    --             replace = "DiffAdd",
    --         },
    --     },
    -- },
    { import = "astrocommunity.utility.noice-nvim" },
    {
        "folke/noice.nvim",
        opts = {
            cmdline = { format = { filter = { title = " Shell " } } },
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
            presets = { lsp_doc_border = true },
        },
    },
    { import = "astrocommunity.motion.flash-nvim" },
    {
        "folke/flash.nvim",
        opts = {
            search = { multi_window = false },
            modes = {
                treesitter = { label = { rainbow = { enabled = true } } },
                treesitter_search = { label = { rainbow = { enabled = true } } },
            },
        },
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
        opts = { commented = false, highlight_new_as_changed = true },
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
    { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
    { import = "astrocommunity.motion.nvim-spider" },
    { import = "astrocommunity.motion.vim-matchup" },
    {
        "andymass/vim-matchup",
        dependencies = {
            "AstroNvim/astrocore",
            opts = function(_, opts)
                opts.options.g.matchup_matchparen_offscreen = {}
            end,
        },
    },
    { import = "astrocommunity.git.diffview-nvim" },
    { import = "astrocommunity.editing-support.nvim-treesitter-context" },
    { import = "astrocommunity.recipes.picker-lsp-mappings" },
    { import = "astrocommunity.motion.tabout-nvim" },
    { import = "astrocommunity.split-and-window.colorful-winsep-nvim" },
    {
        "nvim-zh/colorful-winsep.nvim",
        opts = {
            animate = { enabled = false },
            indicator_for_2wins = { position = false },
        },
    },
    { import = "astrocommunity.lsp.actions-preview-nvim" },
    {
        "aznhe21/actions-preview.nvim",
        opts = function(_, opts)
            opts.snacks = {
                layout = {
                    preset = "vertical",
                    layout = {
                        width = 0.8,
                        [2] = { height = 0.2 },
                        [3] = { height = false },
                    },
                },
            }
            opts.highlight_command = { require("actions-preview.highlight").delta() }
        end,
    },
}
