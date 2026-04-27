local function change_choice_node()
    local ls = require("luasnip")
    if not ls.choice_active() then
        return
    end
    if #ls.get_current_choices() > 3 then
        require("luasnip.extras.select_choice")()
    else
        ls.change_choice(1)
    end
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
--
-- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
return {
    -- First key is the mode
    n = {
        -- Second key is the lefthand side of the map

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus

        -- Workspaces
        ["<Leader>s"] = { group = "󰓩 Wokspaces" },
        ["<Leader>sn"] = { "<Cmd>tabnext<CR>", desc = "Next workspace" },
        ["<Leader>sp"] = { "<Cmd>tabprevious<CR>", desc = "Previous workspace" },
        ["<Leader>so"] = { "<Cmd>tabonly<CR>", desc = "Close all workspaces except current" },
        ["<Leader>sc"] = { require("astrocore.buffer").close_tab, desc = "Close current workspace" },
        ["<Leader>sN"] = { "<Cmd>tabnew<CR>", desc = "New workspace" },
        -- Remap replaced commands
        ["<Leader>j"] = { "J", desc = "Join lines" },
        -- Move the force save key
        ["<Leader>W"] = { "<Cmd>w!<CR>", desc = "Force save" },
        -- Open terminals
        ["<Leader>tt"] = {
            function()
                require("astrocore").toggle_term_cmd({ cmd = "btop", direction = "float" })
            end,
            desc = "ToggleTerm btop",
        },
        ["<Leader>tp"] = {
            function()
                require("astrocore").toggle_term_cmd({ cmd = "ipython", direction = "float" })
            end,
            desc = "ToggleTerm python",
        },
        -- Pickers
        ["<Leader>fa"] = {
            function()
                require("snacks.picker").files({
                    dirs = { vim.fn.stdpath("config") },
                    cwd = vim.fn.stdpath("config"),
                    desc = "Config Files",
                })
            end,
            desc = "Find AstroNvim config files",
        },
        ["<Leader>fH"] = { "<Cmd>lua require('snacks.picker').highlights()<CR>", desc = "Find highlight groups" },
        ["<Leader>fi"] = { "<Cmd>lua require('snacks.picker').icons()<CR>", desc = "Find icons" },
        ["<Leader>P"] = { "<Cmd>lua require('snacks.picker').projects()<CR>", desc = "Find projects" },
        -- Trouble
        ["<Leader>xX"] = { "<Cmd>Trouble diagnostics toggle<CR>", desc = "Trouble Workspace Diagnostics" },
        ["<Leader>xx"] = { "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Trouble Document Diagnostics" },
        ["<Leader>xt"] = { "<Cmd>Trouble todo<CR>", desc = "Trouble Todo" },
        ["<Leader>xT"] = { "<Cmd>Trouble todo filter={tag={TODO,FIX,FIXME}}<CR>", desc = "Trouble Todo/Fix/Fixme" },
        ["<Leader>bt"] = { "<Cmd>Hbac toggle_autoclose<CR>", desc = "Toggle autoclose buffers" },
        ["<Leader><Leader>"] = { group = "󰐕 More commands" },
        -- Text search
        ["<Leader><Leader>/"] = { "<Cmd>noh<CR>", desc = "Clear highlighted text" },
        -- Rainbow delimiters
        ["<Leader><Leader>r"] = { "<Cmd>e<CR>", desc = "Reload rainbow delimiters" },
        -- Comment Box
        ["<Leader><Leader>c"] = { group = "󰅺 Comment Box" },
        ["<Leader><Leader>cn"] = { "<Cmd>lua require('comment-box').llbox()<CR>", desc = "Normal box" },
        ["<Leader><Leader>cH"] = { "<Cmd>lua require('comment-box').lcbox(7)<CR>", desc = "Header box" },
        ["<Leader><Leader>ch"] = { "<Cmd>lua require('comment-box').lcline()<CR>", desc = "Header line" },
        ["<Leader><Leader>cs"] = { "<Cmd>lua require('comment-box').albox(18)<CR>", desc = "Separator box" },
        ["<Leader><Leader>cd"] = { "<Cmd>lua require('comment-box').dbox()<CR>", desc = "Delete box" },
        ["<Leader><Leader>cy"] = { "<Cmd>lua require('comment-box').yank()<CR>", desc = "Copy box content" },
        -- Misc
        ["=a"] = { require("utils").restore_view("gg=G"), desc = "Indent file" },
        ["<LocalLeader>r"] = { "<Cmd>lua require('snacks.image').hover()<CR>", desc = "Render image" },
    },
    i = {
        ["<C-g>"] = { "<C-k>*", desc = "Type Greek characters" },
        -- <C-v> in insert mode means inserting the next character literally
        ["<M-j>"] = { "<C-v>j", desc = "Type j character" },
        ["<C-q>"] = {
            change_choice_node,
            desc = "Change current choice node",
        },
    },
    t = {
        -- Setting a mapping to "<nop>" will disable it
        -- ["<Esc>"] = { "<nop>" },
        ["<M-j><M-k>"] = { "<C-\\><C-n>", desc = "Exit insert mode" },
    },
    v = {
        ["<C-w>"] = { desc = "Store text for snippet" },
        ["<C-q>"] = {
            change_choice_node,
            desc = "Change current choice node",
        },
    },
}
