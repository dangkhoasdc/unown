; extends

; Capture underscore-prefixed constants (e.g. _ABC_BDF) as @constant,
; since the built-in query only matches ^[A-Z] patterns.
((identifier) @constant
  (#lua-match? @constant "^_[A-Z][A-Z_0-9]*$"))
