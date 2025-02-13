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

(infix_id
  [
    (variable) @function.call
    (qualified
      (variable) @function.call)
  ])
