;; extends

(none) @constant.builtin

(elude "..") @operator

(lambda
  pattern: (ident)
  "=>" @operator)

(field
  (ident)
  field: (ident) @variable.member)

(call
  item: (field
    (_)
    field: (ident) @function .))

(linebreak) @punctuation

((label "<" ">") @markup.link.label
  (#set! priority 105))

(ref) @markup.link.label
