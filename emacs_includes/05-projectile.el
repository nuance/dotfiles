(use-package projectile
  :straight t
  :hook ('prog-mode-hook . 'projectile-mode)
  :bind (("s-t" . 'projectile-find-file)))
