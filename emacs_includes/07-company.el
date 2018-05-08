(use-package company
  :ensure t
  :init (setq
	 company-idle-delay 0.1
	 company-auto-complete t
	 company-minimum-prefix-length 1)
  :config (progn
	    (global-company-mode)
	    (add-to-list 'company-backends 'company-yasnippet)
	    (add-to-list 'company-frontends 'company-tng-frontend)
	    (setq company-transformers '(company-sort-prefer-same-case-prefix))))

(use-package company-quickhelp
  :ensure t
  :init (setq company-quickhelp-delay 0.1)
  :config (company-quickhelp-mode))
