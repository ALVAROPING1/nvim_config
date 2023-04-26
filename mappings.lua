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
            c = { "<cmd>tabclose<cr>", "Close current workspace" },
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
        -- Text search
        ["<C-/>"] = { "<cmd>noh<cr>", desc = "Clear highlighted text" },
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
        ["<left>"] = { "<nop>" },
        ["<right>"] = { "<nop>" },
        ["<up>"] = { "<nop>" },
        ["<down>"] = { "<nop>" },
        -- Move the force save key
        ["<leader>W"] = { "<cmd>w!<cr>", desc = "Force save" },
        -- Nvim-surround group
        ["<C-s>"] = { name = "Surround", desc = "Surround" },
    },
    i = {
        ["<C-g>"] = { "<C-k>*", desc = "Type greek characters" },
        ["<C-j><C-k>"] = { "<C-v>j<C-v>k", desc = "Type jk character sequence" },
        ["<C-j>"] = { "<C-v>j", desc = "Type j character" },
    },
    t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
    },
    v = {
        -- Fast movement
        ["J"] = { "5j", desc = "Fast downwards movement" },
        ["K"] = { "5k", desc = "Fast upwards movement" },
        -- Disable arrow keys
        ["<left>"] = { "<nop>" },
        ["<right>"] = { "<nop>" },
        ["<up>"] = { "<nop>" },
        ["<down>"] = { "<nop>" },
    },
}
