(use-package helm
  :ensure t
  :demand t
  :bind (("M-x" . 'helm-M-x)
	 ("C-x r b" . 'helm-filtered-bookmarks)
	 ("C-x C-f" . 'helm-find-files))
  :config (progn (helm-mode 1)
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
                       helm-etags-match-part-only            'all)))
