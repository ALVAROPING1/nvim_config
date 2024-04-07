-- set vim options here (vim.<first_key>.<second_key> = value)
return {
    opt = {
        -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true,         -- sets vim.opt.number
        spell = false,         -- sets vim.opt.spell
        spelllang = { "en", "es_es" },
        spellfile = {
            ".spell/personal.utf-8.add",
            ".spell/ignore.utf-8.add",
        },
        spelloptions = "camel,noplainbuffer",
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false,        -- sets vim.opt.wrap
        scrolloff = 8,       -- Number of lines to keep above and below the cursor
        sidescrolloff = 8,   -- Number of columns to keep at the sides of the cursor
        linebreak = true,
        breakat = " ",
        breakindent = true,
        breakindentopt = "shift:8,sbr",
        -- showbreak = "󱞩",
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        scrollopt = "ver,hor,jump",
        -- nrformats = "bin,hex,alpha",
        wildignorecase = true,
        title = false,
        colorcolumn = "80",
        textwidth = 80,
        formatoptions = "cqjro",
    },
    -- configure global vim variables (vim.g)
    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
    -- This can be found in the `lua/lazy_setup.lua` file
    g = {
        -- vim.g.<key>
        gitblame_message_template = "   <author>, <date> • <summary>",
        gitblame_message_when_not_committed = "   <author>, <date> • Uncommitted changes",
        gitblame_date_format = "%r",
        gitblame_highlight_group = "GitBlameText",
        rainbow_delimiters_highlight = { "Delimiter1", "Delimiter2", "Delimiter3" },
        -- Disable unused plugin interfaces
        loaded_python3_provider = 0,
        loaded_ruby_provider = 0,
        loaded_node_provider = 0,
        loaded_perl_provider = 0,
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
