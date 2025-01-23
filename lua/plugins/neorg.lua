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
            ["core.todo-introspector"] = { config = { highlight_group = "VirtualText" } },
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
                        ordered = { icons = { "1)", " 1)", "  1)", "   1)", "    1)", "     1)" } },
                        list = { icons = { "•", " •", "  •", "   •", "    •", "     •" } },
                        code_block = {
                            spell_check = false,
                            content_only = false,
                            below = "▀",
                            icons = { code = "", embed = "" },
                            type_highlight = "@neorg.tags.ranged_verbatim.name.word",
                            ---@type RenderFn
                            render = function(config, bufid, node)
                                local concealer = require("neorg.modules.core.concealer.module")
                                concealer.public.icon_renderers.render_code_block(config, bufid, node)
                                local name_node = node:named_child(0) --[[@as TSNode]]
                                local name = vim.treesitter.get_node_text(name_node, bufid)
                                if not (name == "code" or name == "embed") or not (vim.wo.conceallevel >= 2) then
                                    return
                                end

                                local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
                                local concealcursor = vim.wo.concealcursor:find(vim.api.nvim_get_mode().mode) ~= nil
                                local function should_conceal(row)
                                    return row ~= cursor_row or concealcursor
                                end

                                local row, col, end_row = node:range()
                                if should_conceal(end_row) then
                                    vim.api.nvim_buf_set_extmark(bufid, ns, end_row, col, {
                                        virt_text = { { config.below:rep(vim.o.columns), config.highlight .. ".fg" } },
                                        virt_text_pos = "overlay",
                                    })
                                end

                                if should_conceal(row) then
                                    local name_icon = config.icons[name]
                                    vim.api.nvim_buf_set_extmark(bufid, ns, row, col, {
                                        end_col = ({ name_node:end_() })[2],
                                        virt_text = { { name_icon, { config.type_highlight, config.highlight } } },
                                        virt_text_pos = "overlay",
                                        conceal = " ",
                                    })
                                    local lang_node = node:named_child(1)
                                    if lang_node ~= nil and lang_node:type() == "tag_parameters" then
                                        local _, lang_col, _, end_col = lang_node:range()
                                        local lang = vim.treesitter.get_node_text(lang_node, bufid)
                                        local icon, icon_hl = require("nvim-web-devicons").get_icon_by_filetype(lang)
                                        if icon ~= nil then
                                            vim.api.nvim_buf_set_extmark(bufid, ns, row, lang_col, {
                                                virt_text = { { icon .. " ", { icon_hl, config.highlight } } },
                                                virt_text_pos = "inline",
                                                hl_group = icon_hl,
                                                end_col = end_col,
                                            })
                                        end
                                    end
                                end
                            end,
                        },
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

        local function create_highlights()
            for i = 1, 6 do
                local color = hl.public.dim_color(hl.public.get_attribute(heading_hl(i, "prefix"), "foreground"), 65)
                vim.api.nvim_set_hl(0, heading_hl(i, "bg"), { bg = color })
                vim.api.nvim_set_hl(0, heading_hl(i, "fg"), { fg = color })
            end
            local code_block = "@neorg.tags.ranged_verbatim.code_block"
            local color = hl.public.get_attribute(code_block, "background")
            vim.api.nvim_set_hl(0, code_block .. ".fg", { fg = "#" .. color })
        end
        create_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = create_highlights })
    end,
}
