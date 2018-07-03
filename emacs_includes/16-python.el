(progn
  (setq quelpa-stable-p nil)
  (use-package blacken
    :ensure t
    :hook ('python-mode-hook . #'blacken-mode))
  (setq quelpa-stable-p t))

(use-package company-jedi
  :ensure t
  :config
  ;; install jedi-server on first run
  (unless (file-directory-p "~/.emacs.d/.python-environments/default")
    (jedi:install-server-block))
  (add-to-list 'company-backends '(company-jedi company-yasnippet)))

(use-package yasnippet
  :ensure t
  :init (setq yas-snippet-dirs '("~/.emacs_includes/snippets"))
  :config (yas-global-mode 1))
