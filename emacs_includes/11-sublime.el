;; Functionality I miss from sublime text (primarily multiple cursor support)

(require 'multiple-cursors)
(global-set-key (kbd "s-L") 'mc/edit-lines)

(defun select-symbol-or-mark-all ()
    "Sets the region to the symbol under the point"
    (interactive)
    (if (use-region-p)
	(progn
	  (mc/mark-all-dwim nil))
      (let ((bounds (find-tag-default-bounds)))
	(progn
	  (push-mark (cdr bounds))
	  (goto-char (car bounds))
	  (setq mark-active t)))))

(global-set-key (kbd "s-d") 'select-symbol-or-mark-all)
(global-set-key (kbd "C-\\") 'comment-or-uncomment-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "s-P") 'smex)

(electric-pair-mode 1)
(show-paren-mode)

(defun beautify-json (start end)
  "Formats JSON at point."
  (interactive "r")
  (shell-command-on-region start end "python -mjson.tool" nil t))
