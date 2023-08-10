-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
    -- first key is the mode
    n = {
        -- second key is the lefthand side of the map
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- Workspaces
        ["<leader>s"] = {
            name = "󰓩 Wokspaces",
            n = { "<cmd>tabnext<cr>", "Next workspace" },
            p = { "<cmd>tabprevious<cr>", "Previous workspace" },
            o = { "<cmd>tabonly<cr>", "Close all workspaces except current" },
            c = { require("astronvim.utils.buffer").close_tab, "Close current workspace" },
            N = { "<cmd>tabnew<cr>", "New workspace" },
        },
        -- Buffers
        ["<leader>b"] = {
            name = "Buffers",
            n = {
                function()
                    require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
                end,
                "Next buffer",
            },
            p = {
                function()
                    require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
                end,
                "Previous buffer",
            },
        },
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        -- Remap replaced commands
        ["<leader>j"] = { "J", desc = "Join lines" },
        -- Insert math blocks in markdown
        ["<leader>m"] = { "a$$<left>", desc = "Insert math block inline (markdown)" },
        ["<leader>M"] = { "o$$$$<left><left>", desc = "Insert math block displaystyle (markdown)" },
        -- Insert TODO comments in markdown
        ["<leader><C-t>"] = { "a <!--TODO: completar esto--><esc>", desc = "Insert generic TODO comment (markdown)" },
        ["<leader><C-d>"] = {
            "a <!--TODO: diapositivas[:]--><esc>F:i",
            desc = "Insert diapositivas TODO comment (markdown)",
        },
        -- Disable arrow keys
        ["<left>"] = { "" },
        ["<right>"] = { "" },
        ["<up>"] = { "" },
        ["<down>"] = { "" },
        -- Move the force save key
        ["<leader>W"] = { "<cmd>w!<cr>", desc = "Force save" },
        -- Nvim-surround group
        ["<C-s>"] = { name = "Surround", desc = "Surround" },
        -- Neotest keybinds
        ["<leader>dt"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle tests summary window" },
        ["<leader>r"] = {
            -- "<cmd>lua require('nabla').toggle_virt({autogen = true})<cr>",
            "<cmd>lua require('nabla').popup()<cr>",
            desc = "Open math render popup",
        },
        -- Open terminals
        ["<leader>tt"] = {
            function()
                require("astronvim.utils").toggle_term_cmd("btop")
            end,
            desc = "ToggleTerm btop",
        },
        ["<leader>tp"] = {
            function()
                require("astronvim.utils").toggle_term_cmd("ipython")
            end,
            desc = "ToggleTerm python",
        },
        ["<leader><leader>"] = {
            name = "󰐕 More commands",
            -- Text search
            ["/"] = { "<cmd>noh<cr>", "Clear highlighted text" },
            -- Rainbow delimiters
            ["r"] = {
                function()
                    vim.cmd("e")
                end,
                "Reload rainbow delimiters",
            },
            ["c"] = {
                name = "󰅺 Comment Box",
                n = { "<cmd>lua require('comment-box').llbox()<cr>", "Normal box" },
                h = { "<cmd>lua require('comment-box').lcbox(7)<cr>", "Header box" },
                s = { "<cmd>lua require('comment-box').albox(18)<cr>", "Separator box" },
                l = { "<cmd>lua require('comment-box').cline(3)<cr>", "Centered line" },
            },
            -- Spelling
            ["l"] = {
                name = "󰓆 Spelling",
                l = { "m][s1z=`]", "Fix previous mistake" },
                i = { "m][s2zg`]", "Ignore previous mistake" },
                a = { "m][s1zg`]", "Mark previous mistake as good" },
            },
            ["w"] = {
                function()
                    if vim.bo.filetype ~= "markdown" then
                        return
                    end

                    local input_file = vim.api.nvim_buf_get_name(0)
                    if input_file == "" then
                        return
                    end
                    local output_file = input_file:match("^(.+)%.[^%.%/]+$") .. ".pdf"

                    local args = require("plenary.path"):new(".pandoc"):is_dir()
                        and { "--data-dir=.pandoc", "--defaults=pandoc_options.yaml" }
                        or {}
                    vim.list_extend(args, { "-o", output_file, input_file })

                    local Job = require("plenary.job")
                    Job
                    ---@diagnostic disable-next-line: missing-fields Fields are optional
                        :new({
                            command = "pandoc",
                            args = args,
                            on_exit = function(job, exit_code)
                                if exit_code ~= 0 then
                                    vim.notify(table.concat(job:stderr_result(), "\n"):sub(1, -2), vim.log.levels.ERROR)
                                else
                                    ---@diagnostic disable-next-line: missing-fields Fields are optional
                                    Job:new({ command = "xdg-open", args = { output_file } }):start()
                                end
                            end,
                        })
                        :start()
                    vim.notify("Exporting PDF...", vim.log.levels.INFO)
                end,
                "Export to PDF with Pandoc",
            },
        },
    },
    i = {
        ["<C-g>"] = { "<C-k>*", desc = "Type Greek characters" },
        ["<C-j><C-k>"] = { "<C-v>j<C-v>k", desc = "Type jk character sequence" },
        ["<C-j>"] = { "<C-v>j", desc = "Type j character" },
        -- Spelling
        ["<C-l>"] = {
            name = "󰓆 Spelling",
            l = { "<C-g>u<Esc>[s1z=`]a<c-g>u", "Fix previous mistake" },
            i = { "<C-g>u<Esc>[s2zg`]a<c-g>u", "Ignore previous mistake" },
            a = { "<C-g>u<Esc>[s1zg`]a<c-g>u", "Mark previous mistake as good" },
        },
    },
    t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<M-j><M-k>"] = { "<C-\\><C-n>", desc = "Exit insert mode" },
    },
    v = {
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        -- Disable arrow keys
        ["<left>"] = { "" },
        ["<right>"] = { "" },
        ["<up>"] = { "" },
        ["<down>"] = { "" },
    },
}
