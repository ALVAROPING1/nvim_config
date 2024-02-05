;; extends
(verbatim) @nospell
(inline_math) @nospell
(ranged_verbatim_tag
    name: (tag_name) @_name
    (#any-of? @_name "code" "math")
    content: (ranged_verbatim_tag_content) @nospell)
