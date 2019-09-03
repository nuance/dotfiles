(when (window-system)
  (use-package magit
    :straight t
    :commands magit-status magit-blame
    :init
    (defadvice magit-status (around magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
      (delete-other-windows))
    :config
    (setq magit-branch-arguments nil
          ;; use ido to look for branches
          magit-completing-read-function 'magit-ido-completing-read
          ;; don't put "origin-" in front of new branch names by default
          magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
          magit-push-always-verify nil
          ;; Get rid of the previous advice to go into fullscreen
          magit-restore-window-configuration t)

    :bind ("C-x g" . magit-status)))

(use-package yaml-mode
  :straight t
  :mode "\\.yml\\'")

(use-package aggressive-indent
  :straight t
  :config
  (global-aggressive-indent-mode 1))

;; functional helpers
(use-package dash
  :straight t)

;; string manipulation
(use-package s
  :straight t)

;; filepath manipulation
(use-package f
  :straight t)

(use-package smartscan
  :straight t
  :bind (("M-n" . smartscan-symbol-go-forward)
	 ("M-p" . smartscan-symbol-go-backward)))

(use-package thrift-mode
  :straight t)
