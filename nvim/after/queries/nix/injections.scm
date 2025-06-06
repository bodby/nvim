;; extends

; I can't figure out how to remove the indents at the start of each line.
; Perhaps it would be easier to just open a PR for tree-sitter-nix.
; ((comment) @injection.content
;   (#match? @injection.content "^/\\*\\*")
;   (#offset! @injection.content 0 3 0 -2)
;   (#set! injection.language "markdown"))
