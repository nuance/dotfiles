;; Functionality I miss from sublime text (primarily multiple cursor support)

(require 'multiple-cursors)
(global-set-key (kbd "s-L") 'mc/edit-lines)

(defun select-symbol ()
    "Sets the region to the symbol under the point"
    (interactive)
    (let ((bounds (find-tag-default-bounds)))
      (progn
	(set-mark (car bounds))
	(goto-char (cdr bounds))
	(setq mark-active t))))

(global-set-key (kbd "s-d") 'select-symbol)
(global-set-key (kbd "s-D") 'mc/mark-all-symbols-like-this)
(global-set-key (kbd "s-<mouse-1>") 'mc/add-cursor-on-click)

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

(electric-pair-mode 1)
(show-paren-mode)
