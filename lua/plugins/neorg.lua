return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    dependencies = { "max397574/neorg-contexts", "jmbuhr/otter.nvim" },
    opts = {
        load = {
            ["core.defaults"] = { config = { disable = { "core.journal", "core.qol.toc", "core.looking-glass" } } },
            ["core.keybinds"] = {
                config = {
                    hook = function(kb)
                        local leader = kb.leader
                        kb.remap_key("norg", "n", leader .. "id", leader .. "d")
                        kb.remap_key("norg", "n", leader .. "nn", leader .. "n")
                        kb.map("norg", "n", leader .. "q", "<Cmd>Neorg return<CR>", { desc = "[neorg] Exit document" })
                        kb.map(
                            "norg",
                            "n",
                            leader .. "r",
                            "<Cmd>Neorg render-latex toggle<CR>",
                            { desc = "[neorg] Toggle latex rendering" }
                        )
                    end,
                },
            },
            ["core.completion"] = { config = { engine = "nvim-cmp" } },
            ["core.export"] = {},
            ["core.export.markdown"] = { config = { extensions = "all" } },
            ["core.mode"] = {},
            ["core.highlights"] = { config = { highlights = { lists = { ordered = { prefix = "+@markup.list" } } } } },
            -- ["core.ui.calendar"] = {}
            ["core.concealer"] = {
                config = {
                    icons = {
                        code_block = { spell_check = false },
                        ordered = { icons = { "1)", " 1)", "  1)", "   1)", "    1)", "     1)" } },
                        list = { icons = { "•", " •", "  •", "   •", "    •", "     •" } },
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
}
