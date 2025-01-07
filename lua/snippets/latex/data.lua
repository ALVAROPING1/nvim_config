--- Block of groups of snippet specs. The key is the name of the group
---@alias SnippetBlock {[string]: SnippetGroup}

--- Group of snippet specs
---@class SnippetGroup
---@field text true? Whether the snippets will be available inside math or text environment (math by default)
---@field [integer] SnippetSpec

--- Format: `cmds[num_params][group_name][create_autosnippet] = SnippetSpecs`
---@class Cmds
---@field [1] SnippetBlock Commands with no arguments
---@field [2] SnippetBlock Commands with 1 argument
---@field [3] SnippetBlock Commands with 2 arguments

---@class SnippetSpecTable
---@field [1] string Command
---@field [2] string? Name, if `nil` the command should be used
---@field [3] (string | 1 | 2)? Autosnippet trigger, if a number the field indicated by that number should be used. If `nil` no autosnippet should be created
---@field priority number? Priority of the snippet
---@field text true? Whether the snippet will be available inside math or text environment (math by default)

--- Definition a snippet with an optional autosnippet
---@alias SnippetSpec (string | SnippetSpecTable)

--- Definition of an autosnippet
--- Format: `{text, name}`
---@alias AutoSnippetSpec {[1]: string, [2]: string}

--- List of `AutoSnippetSpec`'s. The keys are the triggers
---@alias AutoSnippetSpecs {[string]: AutoSnippetSpec}

-- stylua: ignore
return {
    ---@type Cmds
    cmds = {
        {
            delimiters = {
                { "lceil",  "⌈" }, { "rceil", "⌉" },
                { "lfloor", "⌊" }, { "rfloor", "⌋" },
                { "langle", "⟨" }, { "rangle", "⟩" },
                { "backslash", "\\" },
            },
            delimiter_sizing = {
                "big",  -- "bigl", "bigm", "bigr",
                "Big",  -- "Bigl", "Bigm", "Bigr",
                "bigg", -- "biggl", "biggm", "biggr",
                "Bigg", -- "Biggl", "Biggm", "Biggr",
                "left", "middle", "right"
            },
            greek_letters = {
                { "Gamma",      "Γ", 1 },
                { "Delta",      "Δ", 1 },
                { "Theta",      "Θ" },
                { "Lambda",     "Λ" },
                { "Xi",         "Ξ" },
                { "Pi",         "Π", 1 },
                { "Sigma",      "Σ", 1 },
                { "Upsilon",    "Υ" },
                { "Phi",        "Φ", 1 },
                { "Psi",        "Ψ" },
                { "Omega",      "Ω", 1 },
                -- { "varGamma",   "Italics Γ" },
                -- { "varDelta",   "Italics ∆" },
                -- { "varTheta",   "Italics Θ" },
                -- { "varLambda",  "Italics Λ" },
                -- { "varXi",      "Italics Ξ" },
                -- { "varPi",      "Italics Π" },
                -- { "varSigma",   "Italics Σ" },
                -- { "varUpsilon", "Italics Υ" },
                -- { "varPhi",     "Italics Φ" },
                -- { "varPsi",     "Italics Ψ" },
                -- { "varOmega",   "Italics Ω" },
                { "alpha",      "α", 1 },
                { "beta",       "β", 1 },
                { "gamma",      "γ" },
                { "delta",      "δ", 1 },
                { "epsilon",    "𝝐" },
                { "zeta",       "ζ" },
                { "eta",        "η" },
                { "theta",      "θ", 1 },
                { "iota",       "ι" },
                { "kappa",      "κ" },
                { "lambda",     "λ", 1 },
                { "mu",         "μ", 1 },
                { "nu",         "ν" },
                { "xi",         "ξ" },
                { "pi",         "π", 1 },
                { "rho",        "ρ", 1 },
                { "sigma",      "σ", 1 },
                { "tau",        "τ" },
                { "upsilon",    "υ" },
                { "phi",        "φ", 1 },
                { "chi",        "χ" },
                { "psi",        "𝝍" },
                { "omega",      "ω", 1 },
                { "varepsilon", "ε", "epsilon" },
                -- { "varkappa",   "Ϟ" },
                -- { "vartheta",   "ϑ" },
                -- { "varpi",      "ϖ" },
                -- { "varrho",     "𝝔" },
                -- { "varsigma",   "ς" },
                { "varphi",     "𝝋" },
                -- { "digamma",    "ϝ" },
            },
            other_letters = {
                -- "imath", "jmath",
                -- "Im", "Re",
                { "nabla",   "∇" },
                { "partial", "∂" },
                { "aleph",   "א" },
                { "hbar",    "ħ" }, -- { "hslash", "ħ" },
                { "N", "ℕ", "NN" }, { "Z", "ℤ", "ZZ" }, { "Q", "ℚ", "QQ" }, { "R", "ℝ", "RR" },
            },
            -- vertical_layout = { { "atop", "Character above character" } },
            spacing = {
                { "enspace", nil, 1 },
                { "quad",    nil, 1 }, "qquad",
                -- "nobreakspace",
            },
            logic_and_set_theory = {
                -- { "complement", "∁" },
                -- { "therefore",  "∴" },
                -- { "because",    "∵" },
                { "emptyset",   "∅" },
                -- { "empty",      "∅" },
                -- { "varnothing", "∅" },
                { "subset",     "⊂" },
                { "supset",     "⊃" },
                { "mapsto",     "↦", "!>" },
                -- { "to",         "→" },
                { "implies",    "⟹" },
                -- { "gets",       "←" },
                { "impliedby",  "⟸" },
                { "iff",        "⟺" },
                { "land",       "∧" },
                { "lor",        "∨" },
                { "forall",     "∀", "AA" },
                { "exists",     "∃", "EE" },
                { "nexists",    "∄" },
                { "in",         "∈", "inn" },
                { "notin",      "∉", "ninn" },
                -- { "ni",         "∋" },
                { "neg",        "¬" },
                { "lnot",       "¬" },
            },
            -- macros = {
            --     "def",                        -- "gdef", "edef", "xdef",
            --     "let",                        -- "futurelet", "global",
            --     "newcommand", "renewcommand", -- "providecommand",
            --     -- "long", "char", "mathchoice", "TextOrMath",
            --     -- "@ifstar", "@ifnextchar", "@firstoftwo", "@secondoftwo",
            --     -- "relax", "expandafter", "noexpand"
            -- },
            big_operators = {
                -- { "bigotimes", "⨂" },
                -- { "bigoplus",  "⨁" },
                -- { "bigodot",   "⨀" },
                { "bigvee",    "⋁" },
                { "bigwedge",  "⋀" },
                -- { "coprod",    "∐" },
                { "iint",   "∬" },
                { "iiint",  "∭" },
                { "oint",   "∮" },
                { "oiint",  "∯" },
                { "oiiint", "∰" },
            },
            binary_operators = {
                { "cdot",            "∙",         "**" },
                -- { "bullet",          "∙ (bigger)" },
                -- { "intercal",        "⊺" },
                -- { "leftthreetimes",  "⋋" },
                -- { "rightthreetimes", "⋌" },
                -- { "amalg",           "⨿" },
                { "setminus",        "\\" },
                { "pm",              "±",         "+-" },
                { "mp",              "∓",         "-+" },
                -- { "div",             "÷" },
                -- { "ast",             "∗" },
                { "times",           "×" },
                -- { "oslash",          "⊘" },
                { "odot",            "⊙" },
                { "oplus",           "⊕" },
                -- { "ominus",          "⊖" },
                -- { "otimes",          "⊗" },
                { "cap",             "∩" },
                { "cup",             "∪" },
            },
            -- fractions = { "over", "above" },
            binomial_coefficients = { "choose" },
            relations = {
                { "subseteq",        "⊆" },
                { "supseteq",        "⊇" },
                -- { "subseteqq",       "⫅" },
                -- { "supseteqq",       "⫆" },
                { "ll",              "<<", 2 },
                { "gg",              ">>", 2 },
                { "lll",             "<<<" },
                { "ggg",             ">>>" },
                { "leq",             "<=", 2 },
                { "geq",             ">=", 2 },
                { "lesssim",         "≲" },
                { "gtrsim",          "≳" },
                { "prec",            "≺" },
                { "succ",            "≻" },
                { "preceq",          "⪯" },
                { "succeq",          "⪰" },
                { "not =",           "!=", 2 },
                { "equiv",           "≡", "==" },
                { "sim",             "∼", "~~" },
                { "approx",          "≈", "~=" },
                -- { "eqcolon",         "-:" },
                -- { "coloneq",         ":-" },
                -- { "Coloneq",         "::-" },
                -- { "dashv",           "-|" },
                { "vdash",           "|-" },
                { "vDash",           "|=" },
                -- { "models",           "|=" },
                { "Vdash",           "||-" },
                -- { "Vvdash",          "|||-" },
                { "parallel",        "||" },
                { "perp",            "⊥" },
                { "propto",          "∝" },
            },
            negated_relations = {
                { "nsubseteq",        "⊈" },
                { "nsupseteq",        "⊉" },
                -- { "nleq",             "≰" },
                -- { "ngeq",             "≱" },
                { "nprec",            "⊀" },
                { "nsucc",            "⊁" },
                { "nmid",             "∤" },
                { "nparallel",        "∦" },
            },
            arrows = {
                { "leftarrow",           "←", "-<" },
                -- { "longleftarrow",       "<--" },
                { "rightarrow",          "→", "->" },
                { "longrightarrow",      "-->" },
                -- { "longmapsto",          "|-->" },
                { "leftrightarrow",      "↔" },
                { "longleftrightarrow",  "<-->" },
                -- { "uparrow",             "↑" },
                -- { "downarrow",           "↓" },
                -- { "updownarrow",         "↕" },
                { "Leftarrow",           "⇐", "=<" },
                -- { "nLeftarrow",          "⇍" },
                -- { "Longleftarrow",       "<==" },
                { "Rightarrow",          "⇒", "=>" },
                -- { "nRightarrow",         "⇏" },
                -- { "Longrightarrow",      "==>" },
                { "Leftrightarrow",      "⇔", "<>=", priority = 1200 },
                -- { "nLeftrightarrow",     "⇎" },
                -- { "Longleftrightarrow",  "<==>" },
                -- { "Uparrow",             "⇑" },
                -- { "Downarrow",           "⇓" },
                -- { "Updownarrow",         "⇕" },
                -- { "upuparrows",          "⇈" },
                -- { "downdownarrows",      "⇊" },
                -- { "leftrightarrows",     "⇆" },
                -- { "rightleftarrows",     "⇄" },
            },
            -- font = {
            --     { "rm", "Normal font" },
            --     { "bf", "Bold font" },
            --     { "it", "Italics font" },
            --     { "sf", "Serif font" },
            --     { "tt", "Monospace font" },
            -- },
            size = {
                "Huge", "huge", "LARGE", "Large", "large", "normalsize",
                "small", "footnotesize", "scriptsize", "tiny"
            },
            style = {
                { "displaystyle", nil, "ds" },
                -- "textstyle",
                -- "scriptstyle",
                -- "scriptscriptstyle",
                { "limits",       nil, "lm" },
                -- "nolimits",
                -- "verb",
            },
            symbols_and_punctuation = {
                { "ddots",              "⋱" },
                { "vdots",              "⋮" },
                { "cdots",              "⋯",    "..." },
                -- { "diagdown",           "╲" },
                -- { "diagup",             "╱" },
                { "infty",              "∞",    "inf" },
                { "top",                "⊤" },
                { "bot",                "⊥" },
                { "angle",              "∠" },
                -- { "measuredangle",      "∡" },
                -- { "sphericalangle",     "∢" },
                -- { "surd",               "√" },
                -- { "checkmark",          "✓" },
                -- { "square",             "□" },
                -- { "blacksquare",        "■" },
            },
            -- debugging = { "message", "show" }
        },
        {
            accents = {
                -- { "mathring",            "å" },
                { "dot",                 "ȧ" },
                { "ddot",                "ä" },
                { "hat",                 "â",            "hat" },
                { "widehat",             "Extensible â" },
                { "overline",            "ā",            "bar" },
                { "vec",                 "Thin a⃗",     "vec" },
                -- { "overrightarrow",      "Extensible a⃗" },
            },
            annotation = {
                { "overbrace",  "Top }" },
                { "underbrace", "Bottom }" },
                -- { "boxed",      "Rectangle around contents" },
                -- { "tag",        "Add ID to element at the side" },
            },
            vertical_layout = { { "shortstack", "Multiline text" }, {"substack", "Multiline annotation"} },
            spacing = {
                -- "phantom", "hphantom", "vphantom",
                { "hspace", "Horizontal space", 1 }, { "vspace", "Vertical space", 1 },
            },
            math_operators = { "operatorname", "operatorname*", "operatornamewithlimits" },
            binary_operators = {
                { "pmod",            "(mod N)" },
                { "mod",             "mod N" },
                -- { "pod",             "(N)" },
            },
            sqrt = { { "sqrt", "√", "sq" } },
            extensible_arrows = {
                { "xleftarrow",  "Extensible <-" },
                { "xrightarrow", "Extensible ->" },
                { "xLeftarrow",  "Extensible ⇐" },
                { "xRightarrow", "Extensible ⇒" },
            },
            font = {
                { "text",       "Text mode",           "tt" },
                { "textbf",     "Bold font" },
                { "textit",     "Italics font" },
                { "textrm",     "Normal font" },
                -- { "textsf",     "Serif font" },
                { "texttt",     "Monospace font" },
                { "textnormal", "Normal text font" },
                { "boldsymbol", "Bold math font" },
                { "mathbb",     "Blackboard bold font" },
                { "mathfrak",   "Fraktur font" },
                { "mathcal",    "Calligraphic font" },
                { "mathscr",    "Script font" },
                -- { "symup",      "Non-italic math font" }
                -- { "pmb",        "Bold font on characters without bold glyph" },
            },
            custom = {
                { "abs",    nil, 1 },
                { "ceil",   nil, 1 },
                { "floor",  nil, 1 },
            }
        },
        {
            vertical_layout = {
                -- { "stackrel", "Character above character" },
                { "overset",  "Character above character" },
                { "underset", "Character below character" },
                -- { "raisebox", "Move character upwards" },
            },
            fractions = {
                { "frac", "Fraction" },
                -- { "dfrac", "Display style fraction" },
                -- { "tfrac", "Inline style fraction" },
                -- { "cfrac", "Continued fraction" },
                -- "genfrac"
            },
            binomial_coefficients = {
                { "binom",  "Binomial coefficient" },
                -- { "dbinom", "Display style binomial coefficient" },
                -- { "tbinom", "Inline style binomial coefficient" },
                -- { "brace",  "Binomial coefficient with }" },
                -- { "brack",  "Binomial coefficient with ]" },
            },
            -- color = {
            --     { "textcolor", "Color text" }, { "colorbox", "Color background" }
            -- }
        },
    },
    -- Table with function commands
    ---@type SnippetGroup
    functions = {
        "deg",
        -- "sec", "cot", "csc",
        { "cosh", nil, "hcos" }, { "sinh", nil, "hsin" }, { "tanh", nil, "htan" }, -- "coth",
        -- "ker", "det", "dim",
        "arg", -- "lg",
        "inf", "sup",
        "gcd",
        { "arcsin", nil, 1 }, { "arccos", nil, 1 }, { "arctan", nil, 1 },
        { "sin",    nil, 1 }, { "cos",    nil, 1 }, { "tan",    nil, 1 },
        { "exp",    nil, 1 }, { "log",    nil, 1 }, { "ln",     nil, 1 },
        { "min",    nil, 1 }, { "max",    nil, 1 },
        { "argmin", nil, "amin" }, { "argmax", nil, "amax" },
    },
    -- Table with the operators using subscript/superscrip limits
    ---@type SnippetGroup
    limit_operators = {
        { "bigcap", "⋂" },
        { "bigcup", "⋃" },
        { "sum",    "∑", 1 },
        { "prod",   "∏", 1 },
    },
    ---@type SnippetSpec
    int = { "int", "∫", 1 },
    ---@type SnippetSpec
    limit = { "lim", "Limit", 1 },
    -- Table with the environments
    envs = {
        ---@type SnippetSpec
        generic = { "begin", "Begin environment (generic)", "beg" },
        ---@type SnippetSpec
        aligned = { "aligned", "Begin environment (aligned)", "ali" },
        math = {
            "aligned",
            "alignedat",
            "matrix",
            "pmatrix",
            "bmatrix",
            "vmatrix",
            "Vmatrix",
            "Bmatrix",
            "cases",
            "rcases",
        },
        text = { "tikzpicture", "center", "tabular", "align", "itemize", "enumerate" }
    },
    -- Postfix snippets that just append text
    ---@type AutoSnippetSpecs
    raw_postfix_autosnippets = {
        sr = { "^2", "²" },
        cb = { "^3", "³" },
        inv = { "^{-1\\}", "⁻¹" },
        ss = { "_{$1\\}", "Subscript" },
        SS = { "^{$1\\}", "Superscript" },
    },
    ---@type AutoSnippetSpecs
    postfix_autosnippets = {
        hat = { "hat",      "Hat" },
        bar = { "overline", "Bar" },
        vec = { "vec",      "Vector" },
    }
}
