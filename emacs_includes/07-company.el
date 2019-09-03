(use-package company
  :straight t
  :init (setq
  	 company-idle-delay 0.1
;;         company-auto-complete nil
         company-minimum-prefix-length 3)
  :config
  (global-company-mode)
  (add-to-list 'company-backends 'company-dabbrev)
  (add-to-list 'company-backends 'company-etags)
  (add-to-list 'company-frontends 'company-tng-frontend)
  (setq company-dabbrev-downcase nil))

(use-package company-quickhelp
  :straight t
  :init (setq company-quickhelp-delay 0.1)
  :config (company-quickhelp-mode))
