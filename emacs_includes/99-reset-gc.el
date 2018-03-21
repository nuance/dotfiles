;; Tweak GC to not run while in minibuffer

(defun my/minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))
(defun my/minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my/minibuffer-exit-hook)

;; reset the gc to the default value (increased at start of .emacs)
(setq gc-cons-threshold 800000)
