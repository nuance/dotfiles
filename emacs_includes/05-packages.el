(use-package magit
  :ensure t
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

  :bind ("C-x g" . magit-status))

(use-package monky
  :ensure t
  :init
  (defadvice monky-status (around monky-fullscreen activate)
    (window-configuration-to-register :monky-fullscreen)
    ad-do-it
    (delete-other-windows))
  :config (setq monky-process-type 'cmdserver)
  :bind ("C-x G" . monky-status))

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
