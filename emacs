;; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold most-positive-fixnum)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))

(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)
