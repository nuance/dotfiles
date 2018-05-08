;; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold most-positive-fixnum)

;; pin to a specific git-sha
(let ((straight-sha "eeadf0fdaf6a9e4d89e51ef5f167c5cd99c6d54a"))
  (setq
   ;; don't poll fs for package updates
   straight-check-for-modifications 'live
   ;; only use melpa (FIXME: i wish this was melpa-stable)
   straight-recipe-repositories '(melpa)
   ;; fix branch to the pinned sha
   straight-repository-branch straight-sha)

  (let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
	(bootstrap-version 3))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
	  (url-retrieve-synchronously
	   ;; load bootstrap from the sha
	   (concat "https://raw.githubusercontent.com/raxod502/straight.el/" straight-sha "/install.el")
	   'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

(straight-use-package 'use-package)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file "~/.emacs.d/emacs-custom.el")
(unless (file-exists-p custom-file) (write-region "" "" custom-file))
(load custom-file)

;; === CONCAT ===
;; Content below the previous comment will be replaced with inlined elisp files for the copy of this on https://mhjones.org/emacs.
;; Concatenation is performed via the concat_emacs_config.py script
;; This lets me set up a machine by running 'curl -o .emacs https://mhjones.org/emacs'
(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))
