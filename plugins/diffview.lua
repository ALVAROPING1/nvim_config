return {
    "sindrets/diffview.nvim",
    event = false,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gD", "<cmd>DiffviewOpen<cr>",          desc = "View project Git diff" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "View file history" },
        { "<leader>gF", "<cmd>DiffviewFileHistory<cr>",   desc = "View branch history" },
    },
    opts = function(_, opts)
        local cmd = require("diffview.actions")
        opts.signs = { done = " " } -- Finished resolving merge conflicts
        -- Config for conflicted files in diff views during a merge or rebase.
        opts.view.merge_tool = { layout = "diff4_mixed" }
        opts.file_panel = {
            win_config = {
                width = 30,
            },
        }
        opts.file_history_panel = {
            log_options = {
                git = {
                    single_file = {
                        follow = true,
                        first_parent = true,
                    },
                    multi_file = {
                        first_parent = true,
                    },
                },
            },
        }
        opts.keymaps = {
            disable_defaults = true,
            -- stylua: ignore
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current tabpage is a Diffview.
                { "n", "<tab>",      cmd.select_next_entry,             { desc = "Next file diff" } },
                { "n", "<s-tab>",    cmd.select_prev_entry,             { desc = "Previous file diff" } },
                { "n", "<C-w>f",     cmd.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
                { "n", "<leader>o",  cmd.focus_files,                   { desc = "Bring focus to file panel" } },
                { "n", "<leader>e",  cmd.toggle_files,                  { desc = "Toggle the file panel" } },
                { "n", "[x",         cmd.prev_conflict,                 { desc = "Jump to previous conflict" } },
                { "n", "]x",         cmd.next_conflict,                 { desc = "Jump to next conflict" } },
                { "n", "<leader>co", cmd.conflict_choose("ours"),       { desc = "Choose OURS version" } },
                { "n", "<leader>ct", cmd.conflict_choose("theirs"),     { desc = "Choose THEIRS version" } },
                { "n", "<leader>cb", cmd.conflict_choose("base"),       { desc = "Choose BASE version" } },
                { "n", "<leader>ca", cmd.conflict_choose("all"),        { desc = "Choose ALL versions" } },
                { "n", "<leader>cd", cmd.conflict_choose("none"),       { desc = "Delete the conflict" } },
                { "n", "<leader>cO", cmd.conflict_choose_all("ours"),   { desc = "Choose OURS version for whole file" } },
                { "n", "<leader>cT", cmd.conflict_choose_all("theirs"), { desc = "Choose THEIRS version for whole file" } },
                { "n", "<leader>cB", cmd.conflict_choose_all("base"),   { desc = "Choose BASE version for whole file" } },
                { "n", "<leader>cA", cmd.conflict_choose_all("all"),    { desc = "Choose ALL versions for whole file" } },
                { "n", "<leader>cD", cmd.conflict_choose_all("none"),   { desc = "Delete the conflict for whole file" } },
            },
            diff1 = {
                -- Mappings in single window diff layouts
                { "n", "g?", cmd.help({ "view", "diff1" }), { desc = "Open the help panel" } },
            },
            diff2 = {
                -- Mappings in 2-way diff layouts
                { "n", "g?", cmd.help({ "view", "diff2" }), { desc = "Open the help panel" } },
            },
            -- stylua: ignore
            diff3 = {
                -- Mappings in 3-way diff layouts
                { { "n", "x" }, "2do", cmd.diffget("ours"),           { desc = "Obtain diff hunk from OURS version" }, },
                { { "n", "x" }, "3do", cmd.diffget("theirs"),         { desc = "Obtain diff hunk from THEIRS version" } },
                { "n",          "g?",  cmd.help({ "view", "diff3" }), { desc = "Open the help panel" } },
            },
            -- stylua: ignore
            diff4 = {
                -- Mappings in 4-way diff layouts
                { { "n", "x" }, "1do", cmd.diffget("base"),           { desc = "Obtain diff hunk from BASE version" } },
                { { "n", "x" }, "2do", cmd.diffget("ours"),           { desc = "Obtain diff hunk from OURS version" }, },
                { { "n", "x" }, "3do", cmd.diffget("theirs"),         { desc = "Obtain diff hunk from THEIRS version" }, },
                { "n",          "g?",  cmd.help({ "view", "diff4" }), { desc = "Open the help panel" } },
            },
            -- stylua: ignore
            file_panel = {
                { "n", "j",             cmd.next_entry,                    { desc = "Move cursor to next file entry" } },
                { "n", "k",             cmd.prev_entry,                    { desc = "Move cursor to previous file entry" } },
                { "n", "<cr>",          cmd.select_entry,                  { desc = "Open diff for the selected entry" } },
                { "n", "l",             cmd.select_entry,                  { desc = "Open diff for the selected entry" } },
                { "n", "<2-LeftMouse>", cmd.select_entry,                  { desc = "Open diff for the selected entry" } },
                { "n", "-",             cmd.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
                { "n", "S",             cmd.stage_all,                     { desc = "Stage all entries" } },
                { "n", "U",             cmd.unstage_all,                   { desc = "Unstage all entries" } },
                { "n", "d",             cmd.restore_entry,                 { desc = "Discard changes in entry" } },
                { "n", "L",             cmd.open_commit_log,               { desc = "Open the commit log panel" } },
                { "n", "h",             cmd.close_fold,                    { desc = "Collapse fold" } },
                { "n", "<c-b>",         cmd.scroll_view(-0.25),            { desc = "Scroll the view up" } },
                { "n", "<c-f>",         cmd.scroll_view(0.25),             { desc = "Scroll the view down" } },
                { "n", "<tab>",         cmd.select_next_entry,             { desc = "Next file diff" } },
                { "n", "<s-tab>",       cmd.select_prev_entry,             { desc = "Previous file diff" } },
                { "n", "<C-w>f",        cmd.goto_file_edit,                { desc = "Open the file in the previous tabpage" }, },
                { "n", "i",             cmd.listing_style,                 { desc = "Toggle between 'list' and 'tree' views" }, },
                { "n", "R",             cmd.refresh_files,                 { desc = "Update stats and entries in the file list" }, },
                { "n", "<leader>o",     cmd.focus_files,                   { desc = "Bring focus to file panel" } },
                { "n", "<leader>e",     cmd.toggle_files,                  { desc = "Toggle the file panel" } },
                { "n", "[x",            cmd.prev_conflict,                 { desc = "Go to the previous conflict" } },
                { "n", "]x",            cmd.next_conflict,                 { desc = "Go to the next conflict" } },
                { "n", "g?",            cmd.help("file_panel"),            { desc = "Open the help panel" } },
                { "n", "<leader>cO",    cmd.conflict_choose_all("ours"),   { desc = "Choose OURS version for whole file" } },
                { "n", "<leader>cT",    cmd.conflict_choose_all("theirs"), { desc = "Choose THEIRS version for whole file" } },
                { "n", "<leader>cB",    cmd.conflict_choose_all("base"),   { desc = "Choose BASE version for whole file" } },
                { "n", "<leader>cA",    cmd.conflict_choose_all("all"),    { desc = "Choose ALL versions for whole file" } },
                { "n", "<leader>cD",    cmd.conflict_choose_all("none"),   { desc = "Delete the conflict for whole file" } },
            },
            -- stylua: ignore
            file_history_panel = {
                { "n", "g!",            cmd.options,                    { desc = "Open the option panel" } },
                { "n", "<leader>gD",    cmd.open_in_diffview,           { desc = "Open entry in a diffview" } },
                { "n", "y",             cmd.copy_hash,                  { desc = "Copy commit hash of entry" } },
                { "n", "L",             cmd.open_commit_log,            { desc = "Show commit details" } },
                { "n", "j",             cmd.next_entry,                 { desc = "Move cursor to next file entry" } },
                { "n", "k",             cmd.prev_entry,                 { desc = "Move cursor to previous file entry" } },
                { "n", "<cr>",          cmd.select_entry,               { desc = "Open diff for the selected entry." } },
                { "n", "<2-LeftMouse>", cmd.select_entry,               { desc = "Open diff for the selected entry" } },
                { "n", "<c-b>",         cmd.scroll_view(-0.25),         { desc = "Scroll the view up" } },
                { "n", "<c-f>",         cmd.scroll_view(0.25),          { desc = "Scroll the view down" } },
                { "n", "<tab>",         cmd.select_next_entry,          { desc = "Next file diff" } },
                { "n", "<s-tab>",       cmd.select_prev_entry,          { desc = "Previous file diff" } },
                { "n", "<leader>o",     cmd.focus_files,                { desc = "Bring focus to file panel" } },
                { "n", "<leader>e",     cmd.toggle_files,               { desc = "Toggle the file panel" } },
                { "n", "g?",            cmd.help("file_history_panel"), { desc = "Open the help panel" } },
                { "n", "<C-w>f",        cmd.goto_file_edit,             { desc = "Open the file in the previous tabpage" } },
            },
            option_panel = {
                { "n", "<tab>", cmd.select_entry,         { desc = "Change the current option" } },
                { "n", "q",     cmd.close,                { desc = "Close the panel" } },
                { "n", "g?",    cmd.help("option_panel"), { desc = "Open the help panel" } },
            },
            help_panel = {
                { "n", "q",     cmd.close, { desc = "Close help menu" } },
                { "n", "<esc>", cmd.close, { desc = "Close help menu" } },
            },
        }
    end,
}
