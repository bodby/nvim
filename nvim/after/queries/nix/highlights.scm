;; extends

; ((identifier) @module.builtin
;   (#any-of? @module.builtin "builtins" "lib" "pkgs"))

((identifier) @module.builtin
  (#eq? @module.builtin "builtins"))

(binding
  attrpath: (attrpath
    attr: (identifier) @variable)
  (attrset_expression
    (binding_set
      binding: [
        (binding
          attrpath: (attrpath
            attr: (identifier)))
        (inherit)
        (inherit_from)
      ]
      (_))))

(let_expression
  (binding_set
    binding: (binding
      attrpath: (attrpath
        attr: (identifier) @variable))))

(inherit_from
  expression: (variable_expression
    name: (identifier))
  attrs: (inherited_attrs
    attr: (identifier) @variable.member))

(inherit
  attrs: (inherited_attrs
    attr: (identifier) @variable))

function: (_
  name: (identifier) @function.call)

(binding
  attrpath: (attrpath
    attr: (identifier) @function)
  expression: (function_expression))
