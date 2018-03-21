;; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold most-positive-fixnum)

(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))

(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file "~/.emacs.d/emacs-custom.el")
(unless (file-exists-p custom-file) (write-region "" "" custom-file))
(load custom-file)
