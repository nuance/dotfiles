;; Functionality I miss from sublime text (primarily multiple cursor support)

(setq require-final-newline t)

(defun select-symbol ()
    "Sets the region to the symbol under the point"
    (interactive)
    (let ((bounds (find-tag-default-bounds)))
      (progn
	(set-mark (car bounds))
	(goto-char (cdr bounds))
	(setq mark-active t))))

(use-package multiple-cursors
  :straight t
  :bind (("s-L" . 'mc/edit-lines)
	 ("s-d" . 'select-symbol)
	 ("s-D" . 'mc/mark-all-symbols-like-this)
	 ("s-<mouse-1>" . 'mc/add-cursor-on-click)))

(defun comment-line-or-region (beg end)
  "Comment a region or the current line."
  (interactive "*r")
  (save-excursion
    (if (region-active-p)
	(comment-or-uncomment-region beg end)
      (comment-line 1))))

(global-set-key (kbd "C-\\") 'comment-line-or-region)
(global-set-key (kbd "s-/") 'comment-line-or-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "s-P") 'smex)

(global-set-key (kbd "s-t") 'projectile-find-file)

(global-set-key (kbd "s-B") 'compile)
(global-set-key (kbd "s-b") 'recompile)

(use-package dtrt-indent
  :straight t
  :config
  (dtrt-indent-mode 1)
  )

(electric-pair-mode 1)
(show-paren-mode)

(use-package diff-hl
  :straight t
  :config
  (progn
    (global-diff-hl-mode)
    (diff-hl-margin-mode)))

(global-linum-mode)
(global-hl-line-mode +1)
(global-auto-revert-mode t)
