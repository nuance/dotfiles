(progn
  (setq quelpa-stable-p nil)
  (use-package cquery
    :straight t
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
	  (lsp)
	(user-error nil)))
    :init
    (use-package lsp-mode
      :straight t
      :config
      (setq
       lsp-ui-sideline-show-code-actions nil
       lsp-ui-sideline-show-hover nil
       ))
    (use-package company-lsp
      :straight t
      :config (add-to-list 'company-backends 'company-lsp))
    (use-package lsp-ui
      :straight t
      :init (add-hook 'lsp-mode-hook 'lsp-ui-mode))
    (use-package lsp-ui-flycheck
      :init (add-hook 'lsp-after-open-hook (lambda () (lsp-ui-flycheck-enable 1))))
    (use-package helm-xref
      :straight t
      :config
      (setq xref-show-xrefs-function 'helm-xref-show-xrefs))
    (add-hook 'c-mode-common-hook #'cquery//enable)
    (defun cquery-cache-dir (dir)
      (expand-file-name cquery-cache-dir "/home/mhj/.cquery_cache"))
    (setq cquery-cache-dir-function #'cquery-cache-dir)h
    :config
    (setq
     cquery-executable "/bin/cquery"
     cquery-extra-args '("--log-file=/tmp/cq.log")
     cquery-extra-init-params '(:completion (:detailedLabel t))
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
    :straight t
    :config
    (progn
      (defun clang-format-before-save ()
        "Add this to .emacs to clang-format on save
 (add-hook 'before-save-hook 'clang-format-before-save)."

        (interactive)
        (when (eq major-mode 'c++-mode) (clang-format-buffer))))
    :hook ('before-save . #'clang-format-before-save))

  (setq quelpa-stable-p t))

(use-package antlr-mode
  :mode ("\\.g4\\'" . antlr-mode)
  :straight t)

(use-package c++-mode
  :mode ("\\.h|\\.cpp" . c++-mode))
