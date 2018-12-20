;; Functionality I miss from sublime text (primarily multiple cursor support)

(setq require-final-newline t)

(use-package expand-region
  :straight t
  :bind (("s-f" . 'er/expand-region)
         ("s-F" . 'er/contract-region)))

(use-package multiple-cursors
  :straight t
  :config
  (defun select-symbol (arg)
    "Sets the region to the symbol under the point"
    (interactive "p")
    (if mark-active (mc/mark-next-like-this arg) (er/mark-symbol)))
  (defun mark-all-like-symbol (arg)
    (interactive "p")
    (progn
      (unless mark-active (er/mark-symbol))
      (mc/mark-all-like-this)))
  (add-to-list 'mc/unsupported-minor-modes 'company-mode)
  (add-to-list 'mc/unsupported-minor-modes 'company-quickhelp-mode)
  (add-to-list 'mc/unsupported-minor-modes 'eldoc-mode)
  (add-to-list 'mc/unsupported-minor-modes 'flycheck-mode)
  (add-to-list 'mc/unsupported-minor-modes 'helm-mode)
  (add-to-list 'mc/unsupported-minor-modes 'lsp-ui-doc-mode)
  (add-to-list 'mc/unsupported-minor-modes 'lsp-ui-sideline-mode)
  (add-to-list 'mc/unsupported-minor-modes 'lsp-ui-mode)
  :bind (("s-L" . 'mc/edit-lines)
         ("s-d" . 'select-symbol)
         ("s-M-d" . 'er/mark-symbol)
         ("s-D" . 'mark-all-like-symbol)
         ("s-<mouse-1>" . 'mc/add-cursor-on-click)))

(defun comment-line-or-region (beg end)
  "Comment a region or the current line."
  (interactive "*r")
  (save-excursion
    (if (region-active-p)
        (comment-or-uncomment-region beg end)
      (comment-line 1))))

(global-set-key (kbd "s-a") 'mark-whole-buffer)

(global-set-key (kbd "C-\\") 'comment-line-or-region)
(global-set-key (kbd "s-/") 'comment-line-or-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

(global-set-key (kbd "s-B") 'compile)
(global-set-key (kbd "s-b") 'recompile)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(global-set-key (kbd "s-k s-u") 'upcase-region)
(global-set-key (kbd "s-k s-l") 'downcase-region)

(global-set-key (kbd "s-l") 'goto-line)

(defun dedent (start end)
  (interactive "*r")
  (indent-rigidly start end (- tab-width)))

(defun indent (start end)
  (interactive "*r")
  (indent-rigidly start end tab-width))

(global-set-key (kbd "s-[") 'dedent)
(global-set-key (kbd "s-]") 'indent)

(use-package dtrt-indent
  :straight t
  :config
  (dtrt-indent-mode 1)
  )

(electric-pair-mode 1)
(show-paren-mode)

(progn
  (setq quelpa-stable-p nil)
  (use-package nlinum
    :straight t
    ;; :quelpa (nlinum-1.8.1 :fetcher file :path "~/.emacs_includes/external/nlinum-1.8.1.el")
    :config
    (global-nlinum-mode))
  (setq quelpa-stable-p t))

(when (window-system)
  (use-package diff-hl
    :straight t
    :config
    (global-diff-hl-mode)
    (diff-hl-margin-mode)))

(global-hl-line-mode +1)
(global-auto-revert-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq compilation-scroll-output 'first-error)
(use-package ansi-color
  :config
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region compilation-filter-start (point))
    (toggle-read-only))
  :hook ('compilation-filter . #'colorize-compilation-buffer))

(global-set-key (kbd "s-p") 'helm-etags-select)
(global-set-key (kbd "s-t") 'helm-buffers-list)

(global-set-key (kbd "M-j") 'previous-multiframe-window)
(global-set-key (kbd "M-k") 'other-window)

(use-package ace-window
  :straight t
  :config
  (defun switch-to-nth-window (window-num)
    (let ((window (nth window-num (aw-window-list))))
      (when window (select-window window))))
  :bind (
         ("s-1" . (lambda () (interactive) (switch-to-nth-window 0)))
         ("s-2" . (lambda () (interactive) (switch-to-nth-window 1)))
         ("s-3" . (lambda () (interactive) (switch-to-nth-window 2)))
         ("s-4" . (lambda () (interactive) (switch-to-nth-window 3)))
         ("s-5" . (lambda () (interactive) (switch-to-nth-window 4)))
         ("s-6" . (lambda () (interactive) (switch-to-nth-window 5)))
         ("s-7" . (lambda () (interactive) (switch-to-nth-window 6)))
         ("s-8" . (lambda () (interactive) (switch-to-nth-window 7)))
         ("s-9" . (lambda () (interactive) (switch-to-nth-window 8)))
         ("s-0" . (lambda () (interactive) (switch-to-nth-window 9)))
         ("s-T" . ace-window)))
