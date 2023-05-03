return {
    -- Configure AstroNvim updates
    updater = {
        remote = "origin",     -- remote to use
        channel = "stable",    -- "stable" or "nightly"
        version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "nightly",    -- branch name (NIGHTLY ONLY)
        commit = nil,          -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false,  -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_quit = false,     -- automatically quit the current session after a successful update
        remotes = {            -- easily add new remotes to track
            --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
            --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
            --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        },
    },
    -- Set colorscheme to use
    colorscheme = "vscode",
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
    },
    lsp = {
        mappings = {
            n = {
                ["gk"] = {
                    function()
                        vim.lsp.buf.hover()
                    end,
                    desc = "Hover symbol details",
                },
                ["K"] = false,
            },
        },
        -- customize lsp formatting options
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true,     -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                "marksman",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
        },
    },
    -- Configure require("lazy").setup() options
    lazy = {
        defaults = { lazy = true },
        performance = {
            rtp = {
                -- customize default disabled vim plugins
                disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
            },
        },
    },
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        -- Set up custom filetypes
        -- vim.filetype.add {
        --   extension = {
        --     foo = "fooscript",
        --   },
        --   filename = {
        --     ["Foofile"] = "fooscript",
        --   },
        --   pattern = {
        --     ["~/%.config/foo/.*"] = "fooscript",
        --   },
        -- }
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        local utils = require("user.utils")

        require("dap").configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = utils.get_python_path(vim.loop.cwd()),
                cwd = vim.loop.cwd(),
            },
        }

        require("mason-lspconfig").setup_handlers({
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({})
            end,
            -- Next, you can provide a dedicated handler for specific servers.
            ["pyright"] = function()
                require("lspconfig").pyright.setup({
                    before_init = function(_, config)
                        config.settings.python = {
                            analysis = { extraPaths = { "src/main/python" } },
                            pythonPath = utils.get_python_path(config.root_dir),
                        }
                    end,
                })
            end,
            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                })
            end,
        })
        -- Disable search highlight being disabled on cursor movement
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
    end,
}
