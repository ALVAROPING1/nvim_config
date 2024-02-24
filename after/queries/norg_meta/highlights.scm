;; extends
(key) @nospell
(pair
    (key) @_name
    (#any-of? @_name "author" "authors")) @nospell
(pair
    (key) @_name
    (#eq? @_name "header-includes")
    (array
        (string) @_line @nospell
        (#not-match? @_line "^#")
    ))
