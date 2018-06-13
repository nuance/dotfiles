(use-package cquery
  :ensure t
  :if
  (file-exists-p "/bin/cquery")
  :bind
  (:map c-mode-base-map
        ("M-." . xref-find-definitions)
        ("C-t h c" . cquery-call-hierarchy)
        ("C-t h i" . cquery-inheritance-hierarchy)
        ("C-t i" . lsp-ui-sideline-toggle-symbols-info)
        ("C-t I". helm-imenu)
        ("C-t h m" . cquery-member-hierarchy)
        ("C-t ." . lsp-ui-peek-find-definitions)
        ("C-t ?" . lsp-ui-peek-find-references))
  :preface
  (defun cquery//enable ()
    (condition-case nil
        (lsp-cquery-enable)
      (user-error nil)))
  :init
  (use-package lsp-mode
    :ensure t
    :config
    (setq
     lsp-ui-sideline-show-code-actions nil
     lsp-ui-sideline-show-hover nil
     ))
  (use-package company-lsp
    :ensure t
    :config (add-to-list 'company-backends 'company-lsp))
  (use-package lsp-ui
    :ensure t
    :init (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  (use-package helm-xref
    :ensure t
    :config
    (setq xref-show-xrefs-function 'helm-xref-show-xrefs))
  (add-hook 'c-mode-common-hook #'cquery//enable)
  :config
  (setq
   cquery-executable "/bin/cquery"
   cquery-extra-args '("--log-file=/data/users/mhj/cquery.log")
   cquery-extra-init-params '(:completion (:detailedLabel t)
                                          :index (:comments 2)
                                          :cacheFormat "msgpack"
                                          :cacheDirectory "/data/users/mhj/cquery.cache"
                                          :compilationDatabaseDirectory "/home/mhj/")
   cquery-sem-highlight-method 'font-lock
   company-transformers nil
   company-lsp-async t
   company-lsp-cache-candidates nil
   xref-prompt-for-identifier '(not
                                xref-find-definitions
                                xref-find-definitions-other-window
                                xref-find-definitions-other-frame
                                xref-find-references)))
(use-package clang-format
  :ensure t
  :config
  (progn
    (defun clang-format-before-save ()
      "Add this to .emacs to clang-format on save
 (add-hook 'before-save-hook 'clang-format-before-save)."

      (interactive)
      (when (eq major-mode 'c++-mode) (clang-format-buffer))))
  :hook ('before-save . #'clang-format-before-save))

(use-package antlr-mode
  :ensure t)


;; (use-package rtags
;;   :ensure t
;;   :init
;;   (setq rtags-autostart-diagnostics t)
;;   (rtags-diagnostics)
;;   (setq rtags-completions-enabled t)
;;   (push 'company-rtags company-backends)
;;   (use-package flycheck-rtags
;;     :ensure t)
;;   (use-package helm-rtags
;;     :ensure t
;;     :config
;;     (setq rtags-display-result-backend 'helm)))