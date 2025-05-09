;; extends

(none) @constant.builtin

(elude "..") @operator

(call
  item: (field
    (_)
    field: (ident) @function .))

(lambda
  pattern: (ident)
  "=>" @operator)

(field
  (ident)
  field: (ident) @variable.member)

(linebreak) @punctuation
