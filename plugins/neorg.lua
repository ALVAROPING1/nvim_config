return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
        "max397574/neorg-contexts",
        {
            "vhyrro/luarocks.nvim",
            priority = 1000, -- We'd like this plugin to load first out of the rest
            config = true,
        },
    },
    opts = {
        load = {
            ["core.defaults"] = { config = { disable = { "core.journal", "core.qol.toc" } } },
            ["core.keybinds"] = {
                config = {
                    hook = function(kb)
                        local leader = kb.leader
                        kb.map_event(
                            "norg",
                            "n",
                            leader .. "c",
                            "core.looking-glass.magnify-code-block",
                            { desc = "[neorg] Open code block in new buffer" }
                        )
                        kb.remap_key("norg", "n", leader .. "id", leader .. "d")
                        kb.remap_key("norg", "n", leader .. "nn", leader .. "n")
                        kb.map("norg", "n", leader .. "q", "<Cmd>Neorg return<CR>", { desc = "[neorg] Exit document" })
                    end,
                },
            },
            ["core.completion"] = { config = { engine = "nvim-cmp" } },
            ["core.export"] = {},
            ["core.export.markdown"] = { config = { extensions = "all" } },
            ["core.mode"] = {},
            ["core.highlights"] = {
                config = {
                    highlights = {
                        lists = {
                            ordered = { prefix = "+@markup.list" },
                        },
                    },
                },
            },
            -- ["core.ui.calendar"] = {}
            ["core.concealer"] = { config = { icons = { code_block = { spell_check = false } } } },
            -- HACK: render correct indentation for nested lists. This would be better done with
            -- https://github.com/nvim-neorg/neorg/pull/1179, but it's not been merged yet
            -- This only works for up to 6 levels of nesting
            ["core.esupports.indent"] = {
                config = {
                    tweaks = {
                        unordered_list2 = 1,
                        unordered_list3 = 2,
                        unordered_list4 = 3,
                        unordered_list5 = 4,
                        unordered_list6 = 5,
                        ordered_list2 = 1,
                        ordered_list3 = 2,
                        ordered_list4 = 3,
                        ordered_list5 = 4,
                        ordered_list6 = 5,
                    },
                },
            },
            ["external.context"] = {},
        },
    },
}
