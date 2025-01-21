;; extends

; FIXME: See if this works. See functions inside attrs inside attrs,
; e.g. pkgs.hello.world.aaa { };
(apply_expression
  function: (select_expression
    attrpath: (attrpath
      attr: (identifier) @function.call .))

(variable_expression
  name: (identifier) @module.builtin
    (#any-of? @module.builtin "nixpkgs" "builtins" "lib" "pkgs"))

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
