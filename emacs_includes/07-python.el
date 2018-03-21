;; flycheck linting

(use-package flycheck
  :straight t
  :hook ('prog-mode . #'global-flycheck-mode))

(use-package pyvenv
  :straight t
  :config
  (progn
    ;; We can safely declare this function, since we'll only call it in Python Mode,
    ;; that is, when python.el was already loaded.
    (declare-function python-shell-calculate-exec-path "python")

    (defun flycheck-virtualenv-executable-find (executable)
      "Find an EXECUTABLE in the current virtualenv if any."
      (if (bound-and-true-p python-shell-virtualenv-root)
	  (let ((exec-path (python-shell-calculate-exec-path)))
	    (executable-find executable))
	(executable-find executable)))

    (defun flycheck-virtualenv-setup ()
      "Setup Flycheck for the current virtualenv."
      (setq-local flycheck-executable-find #'flycheck-virtualenv-executable-find))
    ))

(use-package py-yapf
  :straight t
  :hook (python-mode-hook . py-yapf-enable-on-save))

(use-package company-jedi
  :straight t
  :hook (python-mode-hook . (lambda () (setq company-backends '(company-jedi)))))
