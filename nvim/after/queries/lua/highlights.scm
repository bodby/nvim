;; extends

; ((identifier) @module
;   (#any-of? @module "vim" "M"))

((identifier) @module
  (#any-of? @module "vim" "lib"))

; ((string
;   content: (string_content)) @character
;   (#match? @character "^'.'$"))

; ((string
;   content: (string_content)) @character
;   (#match? @character "^\".\"$"))

; (field
;   name: (identifier) @variable
;   value: (table_constructor
;     (field)
;       (_)))
