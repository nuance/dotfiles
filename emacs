;; -*- mode: emacs-lisp -*-


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(setq gc-cons-threshold most-positive-fixnum)

(customize-set-variable 'nsm-settings-file "~/.emacs_includes/network-security.data")

;; disable the GNU ELPA
(setq package-archives nil)
;; initialize the package system
(package-initialize)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
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

(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file "~/.emacs_includes/custom")
(unless (file-exists-p custom-file) (write-region "" "" custom-file))
(load custom-file)

;; === CONCAT ===
;; Content below the previous comment will be replaced with inlined elisp files for the copy of this on https://mhjones.org/emacs.
;; Concatenation is performed via the concat_emacs_config.py script
;; This lets me set up a machine by running 'curl -o .emacs https://mhjones.org/emacs'
(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))
