;; extends

; ((identifier) @module.builtin
;   (#any-of? @module.builtin "builtins" "lib" "pkgs" "lib'" "pkgs'"))

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))

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
  expression: (_)
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
