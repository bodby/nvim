;; extends

; TODO: Only if this is used as the first attr, i.e. nixpkgs. and not just every instance of
;       nixpkgs.
((identifier) @namespace.builtin
  (#any-of? @namespace.builtin "builtins" "nixpkgs"))

; This took way too long.
(apply_expression
  function: [
    (select_expression
      (attrpath
        .
        (identifier) @function.call .))
    (select_expression
      (attrpath
        (_)
        (identifier) @function.call))
  ])
