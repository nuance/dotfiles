(column-number-mode 1)

;; Set positon to 'line:column'
(setq mode-line-position '((line-number-mode ("%l" (column-number-mode ":%c")))))

(defvar mode-line-project
  '(:propertize
    (:eval (if (projectile-project-name) (concat "[" (projectile-project-name) "]") ""))
    face mode-line-project)
  "Formats the current project.")
(put 'mode-line-project 'risky-local-variable t)

;; (message mode-line-format)
(setq-default mode-line-format
	      '("%e"
		mode-line-front-space
		mode-line-client
		mode-line-modified
		" "
		mode-line-position
		" "
		mode-line-buffer-identification
		" "
		(flycheck-mode flycheck-mode-line)
		" "
		(vc-mode vc-mode)
		" "
		mode-line-project
		" "
		mode-name
		mode-line-misc-info
		mode-line-end-spaces))
