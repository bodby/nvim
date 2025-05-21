;; extends

(block
  (identifier) @constant .)
(return_expression
  (identifier) @constant .)

(block
  (call_expression
    function: (identifier) @constructor) .)

; (match_arm
;   (call_expression
;     function: (identifier) @constructor
;       (#match? @constructor "^[A-Z][a-z_0-9]+$") .))

function: ((identifier) @constructor
  (#match? @constructor "^[A-Z][a-z_0-9]+$") .)

type: ((identifier) @constructor
  (#match? @constructor "^[A-Z][a-z_0-9]+$") .)

(use_declaration
  argument: (identifier) @module)

(use_declaration
  argument: [
    (scoped_identifier
      name: (identifier) @module
        (#match? @module "^[a-z_0-9]+$"))
    (use_as_clause
      (scoped_identifier
        name: (identifier) @module
          (#match? @module "^[a-z_0-9]+$")))
  ])

(use_declaration
  (use_as_clause
    path: [
      (identifier) @module
      (scoped_identifier)
    ]
    alias: (identifier) @module))

(use_declaration
  argument: (scoped_use_list
    list: [
      (use_list
        (identifier) @function)
      (use_list
        (scoped_identifier
          name: (identifier) @function))
    ])
  (#match? @function "^[a-z_0-9]+$"))
