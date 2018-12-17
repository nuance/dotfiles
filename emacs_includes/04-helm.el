(use-package helm
  :ensure t
  :demand t
  :bind (("M-x" . 'helm-M-x)
	 ("C-x b" . 'helm-mini)
	 ("C-x r b" . 'helm-filtered-bookmarks)
	 ("C-x C-f" . 'helm-find-files)
         ("s-r" . 'helm-occur)
         ("s-e" . 'helm-bookmarks)
         ("s-R" . 'helm-semantic)
         ("M-y" . 'helm-show-kill-ring))
  :config (progn (helm-mode 1)
                 (helm-autoresize-mode t)
		 (setq helm-M-x-fuzzy-match                  t
		       helm-bookmark-show-location           t
		       helm-buffers-fuzzy-matching           t
		       helm-completion-in-region-fuzzy-match t
		       helm-file-cache-fuzzy-match           t
		       helm-imenu-fuzzy-match                t
		       helm-mode-fuzzy-match                 t
		       helm-locate-fuzzy-match               t
		       helm-quick-update                     t
		       helm-recentf-fuzzy-match              t
		       helm-semantic-fuzzy-match             t
                       helm-etags-fuzzy-match                t
                       helm-etags-match-part-only            'all
                       helm-split-window-inside-p t)))

(use-package helm-descbinds
  :ensure t
  :config (helm-descbinds-mode))
