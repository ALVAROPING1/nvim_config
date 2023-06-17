local ls = require("user.snippets.luasnips")
local node = ls.node

local M = {}

--- Opts table with snippet condition checking that the matched trigger is the beggining of a command without a "\"
M.COMMAND_BEGIN_CONDITION = {
    ---@param line string Line up until the cursor position
    ---@param matched string Matched string
    ---@return boolean
    condition = function(line, matched)
        local pos = #line - #matched
        -- print(matched)
        return pos == 0 or line:sub(pos, pos):match("[^\\]")
    end,
}

--- Returns the Nth capture group of a snippet, optionally removing the first/last characters
---@param _ _
---@param parent Snippet | Node Parent of the function node
---@param arg1 integer | string Capture group number or environment variable name
---@param arg2 {[1]: integer, [2]: integer}? Number of characters to remove from the start/end of the capture
---@return string
function M.get_capture(_, parent, arg1, arg2)
    local out
    if type(arg1) == "string" then
        out = parent.snippet.env[arg1]
    else
        out = parent.snippet.captures[arg1]
    end
    if arg2 ~= nil then
        out = out:sub(1 + arg2[1], #out - arg2[2])
    end
    return out
end

--- Create list of text nodes with each of the input values
---@param values string[]
---@return Node[]
function M.create_text_nodes(values)
    local nodes = {}
    for _, value in ipairs(values) do
        vim.list_extend(nodes, { node.txt(value) })
    end
    return nodes
end

--- Creates a function node with no node references
---@param fn fun(_: _, parent: Snippet | Node, args: any[]): string Function to run in the node
---@param args any[] Arguments of the function
---@return Node
function M.create_fn_node(fn, args)
    return node.fn(fn, {}, { user_args = args })
end

return M
