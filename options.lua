-- set vim options here (vim.<first_key>.<second_key> = value)
return {
    opt = {
        -- set to true or false etc.
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true,         -- sets vim.opt.number
        spell = false,         -- sets vim.opt.spell
        -- spelllang = { "en", "es_es" },
        -- spellfile = {
        --     vim.env.XDG_CONFIG_HOME .. "/nvim/lua/user/spell/personal-es.utf-8.add",
        --     vim.env.XDG_CONFIG_HOME .. "/nvim/lua/user/spell/personal-en.utf-8.add",
        --     vim.env.XDG_CONFIG_HOME .. "/nvim/lua/user/spell/ignore.utf-8.add",
        -- },
        -- spelloptions = "camel,noplainbuffer",
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false,        -- sets vim.opt.wrap
        linebreak = true,
        breakat = " ",
        breakindent = true,
        breakindentopt = "shift:8,sbr",
        -- showbreak = "󱞩",
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        scrollopt = "ver,hor,jump",
        nrformats = "bin,hex,alpha",
        wildignorecase = true,
    },
    g = {
        mapleader = " ",                 -- sets vim.g.mapleader
        autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true,              -- enable completion at start
        autopairs_enabled = true,        -- enable autopairs at start
        diagnostics_mode = 3,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        gitblame_message_template = "   <author>, <date> • <summary>",
        gitblame_message_when_not_commited = "   Uncommited changes",
        gitblame_date_format = "%r",
        gitblame_highlight_group = "GitBlameText",
        gitblame_delay = 250,
    },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
