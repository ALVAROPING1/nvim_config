---------------------------------------------------------------------------------------------------------------------------------
--- Utils
---------------------------------------------------------------------------------------------------------------------------------

--- Returns the lines of text for a header
---@param prefix string Text to add at the beginning of each line
---@param name string Name of the header
---@return string[] # Lines of text
local function header(prefix, name)
    return { prefix, prefix .. " # " .. name, prefix }
end

--- Adds a section to a given annotation template
---@param template table[] Template to modify
---@param prefix string Text to add at the beginning of each line
---@param name string Name of the section
---@param content string[]? Content of the section. If nil will default to an empty lines
---@param types string[]? Annotation types in which the section will be added. If nil will default to functions only
local function add_section(template, prefix, name, content, types)
    types = types or { "func" }
    local function add_lines(lines)
        for _, text in ipairs(lines) do
            table.insert(template, { nil, text, { type = types } })
            table.insert(template, { nil, text, { type = types, no_results = true } })
        end
    end

    add_lines(header(prefix, name))
    add_lines(content or { prefix .. " $1" })
end

---------------------------------------------------------------------------------------------------------------------------------
--- Templates
---------------------------------------------------------------------------------------------------------------------------------

local function rust_template()
    local out = require("neogen.templates.rustdoc")
    local i = require("neogen.types.template").item

    table.insert(
        out,
        { i.Parameter, "/ * `%s`: $1", { type = { "func" }, before_first_item = header("/", "Parameters") } }
    )
    add_section(out, "/", "Panics")
    add_section(out, "/", "Errors")
    -- add_section(out, "/", "Safety")
    add_section(out, "/", "Examples", { "/ ```", "/ $1", "/ ```" })

    return out
end

---------------------------------------------------------------------------------------------------------------------------------
--- Plugin config
---------------------------------------------------------------------------------------------------------------------------------

---@type LazySpec
return {
    "danymat/neogen",
    opts = function(_, opts)
        local languages = {
            lua = { template = { annotation_convention = "emmylua" } },
            python = { template = { annotation_convention = "numpydoc" } },
            rust = {
                template = { annotation_convention = "custom", custom = rust_template() },
            },
        }
        opts.languages = vim.tbl_deep_extend("force", opts.languages, languages)
    end,
}
