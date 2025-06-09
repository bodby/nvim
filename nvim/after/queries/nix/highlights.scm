;; extends

((comment) @comment.documentation
  (#match? @comment.documentation "^/\\*\\*"))

((binding
  attrpath: (attrpath
    attr: (identifier)) @variable.member))

(has_attr_expression
  expression: (variable_expression
    name: (identifier))
  attrpath: (attrpath
    attr: (identifier) @variable.member))

; (binding
;   attrpath: (attrpath
;     attr: (identifier) @variable .)
;   (attrset_expression
;     (binding_set
;       binding: [
;         (binding
;           attrpath: (attrpath
;             attr: (identifier)))
;         (inherit)
;         (inherit_from)
;       ]
;       (_))))

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

(select_expression
  (variable_expression
  . (identifier) @module
  (#any-of? @module "lib" "pkgs" "lib'" "pkgs'")))

(select_expression
  (variable_expression
  . (identifier) @variable.builtin
  (#eq? @variable.builtin "builtins")))

(formal
  (identifier) @module
  (#any-of? @module "lib" "pkgs" "lib'" "pkgs'"))

(formal
  (identifier) @variable.builtin
  (#eq? @variable.builtin "builtins"))

(function_expression
  universal: (identifier) @module
  (#any-of? @module "lib" "pkgs" "lib'" "pkgs'"))

(function_expression
  universal: (identifier) @variable.builtin
  (#eq? @variable.builtin "builtins"))

(inherit_from
  expression: (variable_expression
    name: (identifier) @module
  (#any-of? @module "lib" "pkgs" "lib'" "pkgs'")))

(inherit_from
  expression: (variable_expression
    name: (identifier) @variable.builtin
  (#eq? @variable.builtin "builtins")))

(inherited_attrs
  attr: (identifier) @module
  (#any-of? @module "lib" "pkgs" "lib'" "pkgs'"))

function: (_
  name: (identifier) @function.call)

(binding
  attrpath: (attrpath
    attr: (identifier) @function)
  expression: (function_expression))

; (inherit_from
;   expression: (variable_expression
;     name: (identifier) @_name)
;   attrs: (inherited_attrs
;     attr: (identifier) @function)
;   (#any-of? @_name "builtins" "lib" "lib'"))

; (inherit_from
;   expression: (select_expression
;     expression: (variable_expression
;       name: (identifier) @_name))
;     attrs: (inherited_attrs
;       attr: (identifier) @function)
;     (#any-of? @_name "builtins" "lib" "lib'"))

; (apply_expression
;   (select_expression
;     expression: (variable_expression
;       name: (identifier) @_name)
;     attrpath: (attrpath
;       attr: (identifier) @function)
;     (#any-of? @_name "lib" "lib'")))

; (binding
;   (select_expression
;     expression: (variable_expression
;       name: (identifier) @_name)
;     attrpath: (attrpath
;       attr: (identifier) @function)
;     (#any-of? @_name "lib" "lib'")))

; TODO: Better type queries.
(select_expression
  expression: (variable_expression
    name: (identifier) @_name @module)
  attrpath: (attrpath
    attr: (identifier) @type)
  (#eq? @_name "types"))

(select_expression
  attrpath: (attrpath
    . attr: (identifier) @_name
    attr: (identifier) @type)
  (#eq? @_name "types"))

(apply_expression
  (select_expression
    expression: (variable_expression
      name: (identifier) @_name))
  argument: (variable_expression
    name: (identifier) @type)
  (#eq? @_name "types"))

(variable_expression
  name: (identifier) @keyword.import
  (#eq? @keyword.import "import"))

(variable_expression
  name: (identifier) @keyword.exception
  (#eq? @keyword.exception "abort"))
