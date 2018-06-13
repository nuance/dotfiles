(use-package projectile
  :ensure t
  :hook ('prog-mode-hook . 'projectile-mode)
  :bind (("s-t" . 'projectile-find-file)))
