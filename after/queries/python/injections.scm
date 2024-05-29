;; extends
(string
  (string_start) @_prefix
  (string_content) @injection.content
  (#match? @_prefix "^r[^\w]+")
  (#set! injection.language "regex"))
