;; extends

((identifier) @module.builtin
  (#eq? @module.builtin "vim"))

((field
  name: (identifier) @variable
  value: (table_constructor
    (field
      (identifier)
      (_)))
  (#set! "priority" 101)))
