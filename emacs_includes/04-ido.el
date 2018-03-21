(ido-mode t)
(ido-everywhere t)

(use-package flx-ido
  :straight t
  :config
  (progn
    (flx-ido-mode t)))
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(use-package smex
  :straight t
  :bind (("M-x" . 'smex)
	 ("M-X" . 'smex-major-mode-commands)
	 ("C-c C-c M-x" . 'execute-extended-command)))
