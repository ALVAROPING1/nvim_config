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
            picker = {
                previewers = {
                    diff = { builtin = false, cmd = { "delta" } }, -- Use delta to preview diffs
                    git = { builtin = false },                     -- Use delta to preview git output
                },
                layouts = {
                    default = { layout = { width = 0.87, [2] = { width = 0.575 } } },
                    vscode = { layout = { [2] = { wo = { winhighlight = "NormalFloat:Pmenu" } } } },
                },
                formatters = { file = { truncate = 60 } },
                sources = {
                    files = {
                        config = function(opts)
                            opts.hidden = vim.uv.fs_stat(".git") ~= nil
                        end,
                    },
                    projects = {
                        confirm = { "tcd", "picker_files" }, -- `tcd` changes directory of the current tab
                        formatters = { file = { filename_only = true } },
                        config = function(opts)
                            local ok, projects = pcall(require, "projects")
                            if not ok then
                                return opts
                            end
                            projects.projects = vim.tbl_map(vim.fs.normalize, projects.projects)
                            return vim.tbl_extend("force", opts, projects)
                        end,
                    },
                },
            },
        },
        -- selene: allow(global_usage)
        init = function()
            _G.dd = function(...)
                require("snacks.debug").inspect(...)
                return ...
            end
            _G.bt = function(...)
                require("snacks.debug").backtrace(...)
            end
            _G.log = function(...)
                require("snacks.debug").log(...)
            end
            vim.print = _G.dd
        end,
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
        keys = {
            {
                "<leader>ft",
                function()
                    ---@diagnostic disable-next-line: undefined-field
                    require("snacks.picker").todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Find TODOs",
            },
        },
    },
    {
        "echasnovski/mini.icons",
        ---@diagnostic disable-next-line: assign-type-mismatch
        init = false,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                config = true,
                -- Extract icons/hl groups from nvim-web-devicons and translate them to the format used by mini.icons
                -- NOTE: this operation is expensive due to having many icons, so we do it in a build step so that it's
                -- only done once whenever the plugin updates
                build = function()
                    ---@param src table<string, Icon>
                    ---@return table<string, MiniIconsCategory>
                    local function translate(src)
                        local tbl = {}
                        for k, v in pairs(src) do
                            tbl[k] = { glyph = v.icon, hl = "DevIcon" .. v.name }
                        end
                        return tbl
                    end

                    -- Get the filetype -> icon name translation table
                    local devicons_ft = require("nvim-web-devicons.filetypes")
                    -- Get the extension and filename icon tables
                    local devicons_ext = require("nvim-web-devicons.default.icons_by_file_extension")
                    local devicons_name = require("nvim-web-devicons.default.icons_by_filename")
                    -- Result filetype icons
                    local filetype = {}
                    -- Hashset of extension icons with a filetype associated
                    local ext_with_filetype = {}
                    -- Iterate through default filetypes. For each, translate it to an icon name, get its icon data, and
                    -- mark the extension as seen
                    for _, ft in ipairs(vim.fn.getcompletion("", "filetype")) do
                        local name = devicons_ft[ft]
                        if name ~= nil then
                            ext_with_filetype[name] = true
                        end
                        local icon = devicons_ext[name] or devicons_name[name]
                        filetype[ft] = icon
                    end
                    -- Get all remaining extension icons
                    local extension = {}
                    for k, v in pairs(devicons_ext) do
                        -- Only keep the icon if we haven't processed it yet and it doesn't correspond with an extension
                        -- that vim.filetype.match() recognizes
                        if
                            filetype[k] == nil
                            and not ext_with_filetype[k]
                            and vim.filetype.match({ filename = "." .. k }) == nil
                        then
                            extension[k] = v
                        end
                    end

                    local os = require("nvim-web-devicons.default.icons_by_operating_system")
                    -- Store the resulting table in a file
                    local M = {
                        extension = translate(extension),
                        filetype = translate(filetype),
                        os = translate(os),
                    }
                    local path = vim.fn.stdpath("data") .. "/lazy/nvim-web-devicons/lua/nvim-web-devicons/mini.lua"
                    local fd = assert(io.open(path, "w+"))
                    fd:write("return " .. vim.inspect(M))
                    fd:close()
                end,
            },
        },
        opts = function(_, opts)
            ---@param icons MiniIconsCategory
            ---@param config DeviconsOverrides?
            local function apply_config(icons, config)
                config = config or {}
                for _, name in ipairs(config.mini_icons or {}) do
                    icons[name].glyph = nil
                end
                for _, name in ipairs(config.mini_all or {}) do
                    icons[name] = nil
                end
                return vim.tbl_deep_extend("force", icons, config.overrides or {})
            end

            local icons = require("icons")
            local devicons = require("nvim-web-devicons.mini")

            opts.directory = icons.directory
            opts.extension = apply_config(devicons.extension, icons.extension)
            opts.filetype = apply_config(devicons.filetype, icons.filetype)
            opts.file = icons.file
            opts.os = devicons.os
            opts.lsp = icons.lsp
            require("mini.icons").mock_nvim_web_devicons()
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
    { "folke/lazydev.nvim", opts = { library = { "nvim-dap-ui" } } },
}
