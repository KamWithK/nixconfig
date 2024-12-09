;; Inject the slint language into the `slint!` macro:
(macro_invocation
  macro: [
    (
      (scoped_identifier
        path: (_) @_macro_path
        name: (_) @_macro_name
      )
    )
    ((identifier) @_macro_name @macro_path)
  ]
  ((token_tree) @injection.content
  (#eq? @_macro_name "slint")
  (#eq? @_macro_path "slint")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "slint")
  (#set! injection.combined)
  (#set! injection.include-children)
  )
)
