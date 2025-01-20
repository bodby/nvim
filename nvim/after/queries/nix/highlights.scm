;; extends

; TODO: PR this as this has been updated and is like 2 lines shorter.
(apply_expression
  function: (select_expression
    attrpath: [
      (attrpath
        .
        attr: (identifier) @function.call .)
      (attrpath
        (_)
        attr: (identifier) @function.call .)
    ]))

(variable_expression
  name: (identifier) @namespace.builtin
    (#any-of? @namespace.builtin "nixpkgs" "builtins" "lib" "pkgs"))

; FIXME: Think there's an easier way to do this.
(binding
  attrpath: (attrpath
    attr: (identifier) @variable)
  expression: (attrset_expression
    (binding_set
      binding: [
        (binding
          attrpath: (attrpath
            attr: (identifier)))
        (inherit
          attrs: (inherited_attrs))
      ]
      (_)
    )))
