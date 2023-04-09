-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>tn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- TODO: test
    -- Buffers
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bn"] = { "]n", desc = "Next buffer" }, -- no funciona
    ["<leader>bp"] = { "[n", desc = "Previous buffer" }, -- no funciona
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
    ["<left>"] = false,
    ["<right>"] = false,
    ["<up>"] = false,
    ["<down>"] = false,
  },
  i = {
    ["<C-g>"] = { "<C-k>*", desc = "Type greek characters" },
    -- ["<C-j><C-k>"] = { "jk", desc = "Type jk character sequence" },
    ["<C-j>"] = { "j", desc = "Type j character" }, -- no funciona
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
    ["<left>"] = false,
    ["<right>"] = false,
    ["<up>"] = false,
    ["<down>"] = false,
  },
}
