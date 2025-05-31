;; extends

; ((identifier) @module
;   (#any-of? @module "vim" "M"))

((identifier) @module
  (#eq? @module "vim"))

; (field
;   name: (identifier) @variable
;   value: (table_constructor
;     (field)
;       (_)))
