(column-number-mode 1)

;; Set positon to 'line:column'
(setq mode-line-position '((line-number-mode ("%l" (column-number-mode ":%c")))))

(defvar mode-line-project
  '(:propertize
    (:eval (if (projectile-project-name) (concat "[" (projectile-project-name) "]") ""))
    face mode-line-project)
  "Formats the current project.")
(put 'mode-line-project 'risky-local-variable t)

(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT aligned respectively."
  (let* ((available-width (- (window-width) (length left) (length right) 2)))
    (format (format "%%%ds " available-width) " ")))

(defvar mode-line-center-space
  '(:propertize
    (:eval (simple-mode-line-render (format-mode-line mode-line-left) (format-mode-line mode-line-right)))
    face mode-line-project)
  "Builds center spacing.")
(put 'mode-line-center-space 'risky-local-variable t)

(setq mode-line-left
      '("%e"
	mode-line-front-space
	mode-line-client
	mode-line-modified
	" "
	mode-line-position
	" "
	mode-line-buffer-identification))

(setq mode-line-right
      '(
	(flycheck-mode flycheck-mode-line)
	" "
	(vc-mode vc-mode)
	" "
	mode-line-project
	" "
	mode-name
	mode-line-misc-info
	mode-line-end-spaces))

(setq-default mode-line-format
	      (append mode-line-left '(mode-line-center-space) mode-line-right))
