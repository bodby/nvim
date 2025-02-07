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

((signature)
  (bind
    name: (variable) @function)
  (#set! "priority" 101))


(infix_id
  [
    (variable) @function.call
    (qualified
      (variable) @function.call)
  ])
