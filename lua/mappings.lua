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
        ["<Leader>s"] = {
            desc = "󰓩 Wokspaces",
            n = { "<Cmd>tabnext<CR>", "Next workspace" },
            p = { "<Cmd>tabprevious<CR>", "Previous workspace" },
            o = { "<Cmd>tabonly<CR>", "Close all workspaces except current" },
            c = { require("astrocore.buffer").close_tab, "Close current workspace" },
            N = { "<Cmd>tabnew<CR>", "New workspace" },
        },
        ["<Leader>c"] = {
            function()
                local bufs = vim.fn.getbufinfo({ buflisted = true })
                require("astrocore.buffer").close(0)
                if require("astrocore").is_available("alpha-nvim") and not bufs[2] then
                    require("alpha").start(true)
                end
            end,
            desc = "Close buffer",
        },
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        -- Remap replaced commands
        ["<Leader>j"] = { "J", desc = "Join lines" },
        -- Disable arrow keys
        -- ["<Left>"] = { "" },
        -- ["<Right>"] = { "" },
        -- ["<Up>"] = { "" },
        -- ["<Down>"] = { "" },
        -- Move the force save key
        ["<Leader>W"] = { "<Cmd>w!<CR>", desc = "Force save" },
        -- Nvim-surround group
        ["<C-s>"] = { desc = "Surround" },
        -- Open terminals
        ["<Leader>tt"] = {
            function()
                require("astrocore").toggle_term_cmd("btop")
            end,
            desc = "ToggleTerm btop",
        },
        ["<Leader>tp"] = {
            function()
                require("astrocore").toggle_term_cmd("ipython")
            end,
            desc = "ToggleTerm python",
        },
        ["<Leader>fH"] = {
            function()
                require("telescope.builtin").highlights()
            end,
            desc = "Find highlight groups",
        },
        ["<Leader>lv"] = {
            function()
                vim.diagnostic.config({ virtual_text = not require("lsp_lines").toggle() })
            end,
            desc = "Toggle virtual diagnostic lines",
        },
        ["<Leader><Leader>"] = {
            desc = "󰐕 More commands",
            -- Text search
            ["/"] = { "<Cmd>noh<CR>", "Clear highlighted text" },
            -- Rainbow delimiters
            ["r"] = { "<Cmd>e<CR>", "Reload rainbow delimiters" },
            ["c"] = {
                name = "󰅺 Comment Box",
                n = { "<Cmd>lua require('comment-box').llbox()<CR>", "Normal box" },
                H = { "<Cmd>lua require('comment-box').lcbox(7)<CR>", "Header box" },
                h = { "<Cmd>lua require('comment-box').lcline()<CR>", "Header line" },
                s = { "<Cmd>lua require('comment-box').albox(18)<CR>", "Separator box" },
                d = { "<Cmd>lua require('comment-box').dbox()<CR>", "Delete box" },
                y = { "<Cmd>lua require('comment-box').yank()<CR>", "Copy box content" },
            },
        },
        ["=a"] = { require("utils").restore_view("gg=G"), desc = "Indent file" },
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
        -- Setting a mapping to false will disable it
        -- ["<Esc>"] = false,
        ["<M-j><M-k>"] = { "<C-\\><C-n>", desc = "Exit insert mode" },
    },
    v = {
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        ["<C-w>"] = { desc = "Store text for snippet" },
        -- Disable arrow keys
        -- ["<Left>"] = { "" },
        -- ["<Right>"] = { "" },
        -- ["<Up>"] = { "" },
        -- ["<Down>"] = { "" },
        ["<C-q>"] = {
            change_choice_node,
            desc = "Change current choice node",
        },
    },
}
