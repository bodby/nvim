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

((signature
   type: (function))
  .
  (bind
    name: (variable) @function)
  (#set! "priority" 101))

((signature
   type: (name))
  .
  (bind
    name: (variable) @variable)
  (#set! "priority" 101))


(infix_id
  [
    (variable) @function.call
    (qualified
      (variable) @function.call)
  ])
