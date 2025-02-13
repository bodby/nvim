;; extends

; (type/unit
;   [
;     "("
;     ")"
;   ] @punctuation.bracket)

; (type/list
;   [
;     "["
;     "]"
;   ] @punctuation.bracket)

((decl/signature
  name: (variable) @_name
  type: (name))
  (bind
    name: (variable) @variable
    (#eq? @_name @variable)))

((decl/signature
  name: (variable) @_name
  type: (context
    type: (function)))
  (bind
    name: (variable) @function
    (#eq? @_name @function)))

((decl/signature
  name: (variable) @_name
  type: (apply))
  (bind
    name: (variable) @variable
    (#eq? @_name @variable)))

(decl/bind
  name: (variable) @function
  (#eq? @function "main"))

(infix_id
  [
    (variable) @function.call
    (qualified
      (variable) @function.call)
  ])
