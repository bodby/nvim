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
  .
  (bind
    name: (variable) @function (#set! "priority" 101)))
