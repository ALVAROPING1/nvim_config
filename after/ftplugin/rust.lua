vim.opt_local.colorcolumn = "100"

require("astrocore").set_mappings({
    n = {
        ["<LocalLeader>m"] = { "<Cmd>RustLsp expandMacro<CR>", desc = "Expand macro recursively" },
        ["<LocalLeader>e"] = { "<Cmd>RustLsp explainError current<CR>", desc = "Explain error" },
        ["<LocalLeader>r"] = { "<Cmd>RustLsp renderDiagnostic current<CR>", desc = "Render diagnostic" },
        ["<LocalLeader>d"] = { "<Cmd>RustLsp openDocs<CR>", desc = "Open doc.rs symbol documentation" },
        ["<LocalLeader>D"] = {
            function()
                local NOTIFY_OPTS = { title = "Cargo" }
                vim.system({ "cargo", "doc", "--open" }, { text = true }, function(out)
                    if out.code ~= 0 then
                        vim.notify(out.stderr, vim.log.levels.ERROR, NOTIFY_OPTS)
                        return
                    end
                end)
                vim.notify("Building documentation...", vim.log.levels.INFO, NOTIFY_OPTS)
            end,
            desc = "Open crate documentation",
        },
        ["<Leader>j"] = { "<Cmd>RustLsp joinLines<CR>", desc = "Join lines" },
    },
}, { buffer = 0 })

for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
