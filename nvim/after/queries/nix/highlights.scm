;; extends

; This took way too long.
(apply_expression
  function: [
    (select_expression
      attrpath: (attrpath
        .
        attr: (identifier) @function.call .))
    (select_expression
      attrpath: (attrpath
        (_)
        attr: (identifier) @function.call .))
  ])

(variable_expression
  name: (identifier) @namespace.builtin
    (#any-of? @namespace.builtin "nixpkgs" "builtins" "lib" "pkgs"))
