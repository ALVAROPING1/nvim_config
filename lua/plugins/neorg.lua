local ns = vim.api.nvim_create_namespace("neorg-conceals")

---@alias RenderFn fun(config: table, bufid: integer, node: TSNode)

---@type RenderFn
local function add_icon(config, bufid, node)
    local row, col = node:start()
    vim.api.nvim_buf_set_extmark(bufid, ns, row, col, {
        virt_text = { config.icon },
        virt_text_pos = "inline",
        hl_mode = "combine",
    })
end

---@type RenderFn
local function clear_icon(_, bufid, node)
    local row, col = node:start()
    local marks = vim.api.nvim_buf_get_extmarks(bufid, ns, { row, col }, { row, col + 1 }, {})
    for _, result in ipairs(marks) do
        local extmark_id = result[1]
        vim.api.nvim_buf_del_extmark(bufid, ns, extmark_id)
    end
end

---@param level integer
---@param attr string
local function heading_hl(level, attr)
    return "@neorg.headings." .. level .. "." .. attr
end

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
                        heading = {
                            icons = { "󰼏", "󰼐", "󰼑", "󰼒", "󰼓", "󰼔" },
                            above = "▄",
                            below = "▀",
                            ---@type RenderFn
                            render = function(config, bufid, node)
                                local concealer = require("neorg.modules.core.concealer.module")
                                concealer.public.icon_renderers.multilevel_on_right(false)(config, bufid, node)
                                if node:type():sub(1, 11) == "link_target" then
                                    return
                                end

                                ---@param icon string
                                ---@param level integer
                                ---@return { [1]: string, [2]: string }[]
                                local function line(icon, level)
                                    local indent = level - 1
                                    return {
                                        { (" "):rep(indent) },
                                        { icon:rep(vim.o.columns - indent), heading_hl(level, "fg") },
                                    }
                                end

                                local text = vim.treesitter.get_node_text(node, bufid)
                                local level = text:find("%s") or text:len() + 1
                                level = level - 1
                                local row, col = node:start()
                                vim.api.nvim_buf_set_extmark(bufid, ns, row, col, {
                                    virt_lines = { line(config.above, level) },
                                    virt_lines_above = true,
                                })
                                vim.api.nvim_buf_set_extmark(bufid, ns, row, col, {
                                    virt_lines = { line(config.below, level) },
                                })
                                vim.api.nvim_buf_set_extmark(bufid, ns, row, col + level - 1, {
                                    end_row = row + 1,
                                    hl_group = heading_hl(level, "bg"),
                                    hl_eol = true,
                                    priority = 0,
                                })
                            end,
                        },
                        link = {
                            link = {
                                icons = {
                                    default = { "󰌹", "@markup.link" },
                                    link_target_url = { "󰖟", "@markup.link" },
                                    link_file_text = { "", "DevIconNorg" },
                                    link_target_timestamp = { "󰃭", "@markup.link" },
                                    link_target_external_file = function(bufid, node)
                                        node = node:next_named_sibling() --[[@as TSNode]]
                                        local name = vim.treesitter.get_node_text(node, bufid)
                                        return { require("nvim-web-devicons").get_icon(name, nil, { default = true }) }
                                    end,
                                    link_target_footnote = function(bufid, node)
                                        node = node:next_named_sibling()
                                        local link_title = vim.treesitter.get_node_text(node, bufid)
                                        return link_title:match("^[-0-9]+$") ~= nil or nil
                                    end,
                                },
                                nodes = { "link", "anchor_definition", "anchor_declaration" },
                                ---@type RenderFn
                                render = function(config, bufid, node)
                                    local location_node =
                                        node:named_child(node:type() == "anchor_definition" and 1 or 0):named_child(0) --[[@as TSNode]]
                                    local icon = config.icons[location_node:type()]
                                    if type(icon) == "function" then
                                        icon = icon(bufid, location_node)
                                        if icon == true then
                                            return
                                        end
                                    end
                                    icon = icon or config.icons.default
                                    add_icon({ icon = { icon[1] .. " ", icon[2] } }, bufid, node)
                                end,
                                clear = clear_icon,
                            },
                        },
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
        local hl = require("neorg.modules.core.highlights.module")
        -- HACK: by default, neorg uses the `dim` highlight table to set the highlight group of verbatim text. This should
        -- check that the group hasn't been set already, but for some reason noice conflicts with the checking logic and
        -- causes the check to fail when the cmdline is opened
        hl.config.public.dim.markup.verbatim = nil
        for i = 1, 6 do
            local color = hl.public.dim_color(hl.public.get_attribute(heading_hl(i, "prefix"), "foreground"), 65)
            vim.api.nvim_set_hl(0, heading_hl(i, "bg"), { bg = color })
            vim.api.nvim_set_hl(0, heading_hl(i, "fg"), { fg = color })
        end
    end,
}
