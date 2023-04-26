return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  "Mofiqul/vscode.nvim",
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User AstroFile",
  },
  {
    "ggandor/leap.nvim",
    event = "User AstroFile",
    config = function() require("leap").add_default_mappings() end,
  },
}
