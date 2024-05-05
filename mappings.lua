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
        ["<tab>"] = {
            function()
                require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
            end,
            desc = "Next buffer",
        },
        ["<S-tab>"] = {
            function()
                require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
            end,
            desc = "Previous buffer",
        },
        ["<leader>c"] = {
            function()
                local bufs = vim.fn.getbufinfo({ buflisted = true })
                require("astronvim.utils.buffer").close(0)
                if require("astronvim.utils").is_available("alpha-nvim") and not bufs[2] then
                    require("alpha").start(true)
                end
            end,
            desc = "Close buffer",
        },
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        -- Remap replaced commands
        ["<leader>j"] = { "J", desc = "Join lines" },
        -- Disable arrow keys
        -- ["<left>"] = { "" },
        -- ["<right>"] = { "" },
        -- ["<up>"] = { "" },
        -- ["<down>"] = { "" },
        -- Move the force save key
        ["<leader>W"] = { "<cmd>w!<cr>", desc = "Force save" },
        -- Nvim-surround group
        ["<C-s>"] = { name = "Surround", desc = "Surround" },
        -- Refactor-nvim group
        ["<leader>r"] = { name = " Refactor" },
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
        -- Move find themes from `ft` to `fT` since it will be more rarely used
        ["<leader>ft"] = false,
        ["<leader>fT"] = {
            function()
                require("telescope.builtin").colorscheme({ enable_preview = true })
            end,
            desc = "Find themes",
        },
        ["<leader><leader>"] = {
            name = "󰐕 More commands",
            -- Text search
            ["/"] = { "<cmd>noh<cr>", "Clear highlighted text" },
            -- Rainbow delimiters
            ["r"] = { "<cmd>e<cr>", "Reload rainbow delimiters" },
            ["c"] = {
                name = "󰅺 Comment Box",
                n = { "<cmd>lua require('comment-box').llbox()<cr>", "Normal box" },
                H = { "<cmd>lua require('comment-box').lcbox(7)<cr>", "Header box" },
                h = { "<cmd>lua require('comment-box').lcline()<cr>", "Header line" },
                s = { "<cmd>lua require('comment-box').albox(18)<cr>", "Separator box" },
                l = { "<cmd>lua require('comment-box').cline(3)<cr>", "Centered line" },
                d = { "<cmd>lua require('comment-box').dbox()<cr>", "Delete box" },
                y = { "<cmd>lua require('comment-box').yank()<cr>", "Copy box content" },
            },
        },
        ["=a"] = { require("user.utils").restore_view("gg=G"), desc = "Indent file" },
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
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<M-j><M-k>"] = { "<C-\\><C-n>", desc = "Exit insert mode" },
    },
    v = {
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        ["<C-w>"] = { desc = "Store text for snippet" },
        -- Disable arrow keys
        -- ["<left>"] = { "" },
        -- ["<right>"] = { "" },
        -- ["<up>"] = { "" },
        -- ["<down>"] = { "" },
        -- Refactor-nvim group
        ["<leader>r"] = { name = " Refactor" },
        ["<C-q>"] = {
            change_choice_node,
            desc = "Change current choice node",
        },
    },
}
