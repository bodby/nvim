;; extends

((identifier) @module.builtin
  (#eq? @module.builtin "vim"))

; FIXME: Is "priority" needed?
((field
  name: (identifier) @variable
  value: (table_constructor
    (field
      (identifier)
      (_)))
  ))
