return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    keys = { { "<LocalLeader>n", "<Plug>(neorg.dirman.new-note)", desc = "[neorg] Create New Note" } },
    version = "*",
    dependencies = { "max397574/neorg-contexts", { "jmbuhr/otter.nvim", version = "v1.15.1" } },
    opts = {
        load = {
            ["core.defaults"] = { config = { disable = { "core.journal", "core.qol.toc", "core.looking-glass" } } },
            ["core.completion"] = { config = { engine = "nvim-cmp" } },
            ["core.export"] = {},
            ["core.export.markdown"] = { config = { extensions = "all" } },
            ["core.highlights"] = {
                config = {
                    highlights = {
                        lists = { ordered = { prefix = "+@markup.list" } },
                        delimiters = { horizontal_line = "+VirtualText" },
                        markup = { verbatim = { [""] = "+MarkupVerbatim" } },
                        headings = {
                            ["1"] = { title = "+NeorgH1", prefix = "+NeorgH1" },
                            ["2"] = { title = "+NeorgH2", prefix = "+NeorgH2" },
                            ["3"] = { title = "+NeorgH3", prefix = "+NeorgH3" },
                            ["4"] = { title = "+NeorgH4", prefix = "+NeorgH4" },
                            ["5"] = { title = "+NeorgH5", prefix = "+NeorgH5" },
                            ["6"] = { title = "+NeorgH6", prefix = "+NeorgH6" },
                        },
                    },
                },
            },
            ["core.concealer"] = {
                config = {
                    icons = {
                        code_block = { spell_check = false, content_only = false },
                        ordered = { icons = { "1)", " 1)", "  1)", "   1)", "    1)", "     1)" } },
                        list = { icons = { "•", " •", "  •", "   •", "    •", "     •" } },
                        heading = { icons = { "󰼏", "󰼐", "󰼑", "󰼒", "󰼓", "󰼔" } },
                    },
                },
            },
            ["core.integrations.otter"] = {
                config = {
                    keys = {
                        hover = "gh",
                        definition = "gd",
                        type_definition = "gD",
                        references = "gr",
                        rename = "<Leader>lr",
                        format = "<Leader>lf",
                        document_symbols = "<Leader>lS",
                    },
                },
            },
            ["core.integrations.image"] = {},
            ["core.latex.renderer"] = {},
            ["external.context"] = {},
        },
    },
    config = function(_, opts)
        require("neorg").setup(opts)
        -- HACK: by default, neorg uses the `dim` highlight table to set the highlight group of verbatim text. This should
        -- check that the group hasn't been set already, but for some reason noice conflicts with the checking logic and
        -- causes the check to fail when the cmdline is opened
        require("neorg.modules.core.highlights.module").config.public.dim.markup.verbatim = nil
    end,
}
