(use-package magit
  :commands magit-status magit-blame
  :init
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))
  :config
  (setq magit-branch-arguments nil
        ;; don't put "origin-" in front of new branch names by default
        magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
        magit-push-always-verify nil
        ;; Get rid of the previous advice to go into fullscreen
        magit-restore-window-configuration t)

  :bind ("C-x g" . magit-status))

(use-package git-timemachine
  :ensure t)

(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

(use-package aggressive-indent
  :ensure t
  :hook ('prog-mode . #'aggressive-indent-mode))

;; functional helpers
(use-package dash
  :ensure t)

;; string manipulation
(use-package s
  :ensure t)

;; filepath manipulation
(use-package f
  :ensure t)

(use-package smartscan
  :ensure t
  :bind (("M-n" . smartscan-symbol-go-forward)
	 ("M-p" . smartscan-symbol-go-backward)))

(use-package eldoc
  :diminish eldoc-mode
  :init (setq eldoc-idle-display 0.1))
