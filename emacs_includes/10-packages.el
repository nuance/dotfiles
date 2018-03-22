(use-package magit
  :straight t)

(use-package yaml-mode
  :straight t
  :mode "\\.yml\\'")

(use-package aggressive-indent
  :straight t
  :hook ('prog-mode . #'aggressive-indent-mode))
