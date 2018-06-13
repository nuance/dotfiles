(use-package lua-mode
  :straight t
  :config
  (flycheck-define-checker lua-luacheck-old
    "A Lua syntax checker using luacheck.

See URL `https://github.com/mpeterv/luacheck'."
    :command ("luacheck"
              ;; "--formatter" "plain"
              ;; "--codes"                   ; Show warning codes
              "--no-color"
              (option-list "--std" flycheck-luacheck-standards)
              (config-file "--config" flycheck-luacheckrc)
              ;; "--filename" source-original
              ;; Read from standard input
              source-original)
    :standard-input t
    :error-patterns
    ((warning line-start
              (optional (minimal-match (one-or-more not-newline)))
              ":" line ":" column
              ": (" (id "W" (one-or-more digit)) ") "
              (message) line-end)
     (error line-start
            (optional (minimal-match (one-or-more not-newline)))
            ":" line ":" column ":"
            ;; `luacheck' before 0.11.0 did not output codes for errors, hence
            ;; the ID is optional here
            (optional " (" (id "E" (one-or-more digit)) ") ")
            (message) line-end))
    :modes lua-mode)
  :hook
  (lua-mode
   .
   (lambda()
     (set (make-local-variable 'compile-command)
          (let ((file (file-name-nondirectory buffer-file-name)))
            (format "luacheck --no-color %s" file))))))
