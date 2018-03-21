(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.1)

(use-package company-quickhelp
  :straight t
  :init
  (setq company-quickhelp-delay 0.1))

