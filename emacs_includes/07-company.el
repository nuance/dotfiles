(use-package company
  :straight t
  :init (setq
	 company-idle-delay 0.1
         ;;         company-auto-complete t
         company-minimum-prefix-length 3)
  :config (progn
	    (global-company-mode)
	    (add-to-list 'company-backends 'company-yasnippet)
	    (add-to-list 'company-frontends 'company-tng-frontend)
	    (setq company-transformers '(company-sort-by-backend-importance))))

(use-package company-quickhelp
  :straight t
  :init (setq company-quickhelp-delay 0.1)
  :config (company-quickhelp-mode))
