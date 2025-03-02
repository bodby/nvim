;; extends

function: (select_expression
  attrpath: (attrpath
    attr: (identifier) @function.call .))

function: (_
  name: (identifier) @function.call)

; (variable_expression
;   name: (identifier) @module.builtin
;     (#any-of? @module.builtin "nixpkgs" "builtins" "lib" "pkgs"))

(binding
  attrpath: (attrpath
    attr: (identifier) @variable)
  expression: (attrset_expression
    (binding_set
      binding: (binding
        attrpath: (attrpath
          attr: (identifier)))
      (_)
    )))

(binding
  attrpath: (attrpath
    attr: (identifier) @variable)
  expression: (attrset_expression
    (binding_set
      binding: (inherit
        attrs: (inherited_attrs))
      (_)
    )))

(let_expression
  (binding_set
    binding: (binding
      attrpath: (attrpath
        attr: (identifier) @variable))))

(binding
  attrpath: (attrpath
    attr: (identifier) @function)
  expression: (function_expression))

(variable_expression
  name: (identifier) @module.builtin
  (#eq? @module.builtin "builtins"))
