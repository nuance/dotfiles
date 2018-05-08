;; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold most-positive-fixnum)

;; disable the GNU ELPA
(setq package-archives nil)
;; initialize the package system
(package-initialize)

;; pin to a specific git-sha
(let ((quelpa-sha "1e57420158c158275c5a098951aca25651a41bc7"))
  (package-initialize)
  (unless (require 'quelpa nil t)
    (with-temp-buffer
      (url-insert-file-contents (concat "https://raw.github.com/quelpa/quelpa/" quelpa-sha  "/bootstrap.el"))
      (eval-buffer))))

(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)
(setq use-package-ensure-function 'quelpa
      quelpa-stable-p t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file "~/.emacs-custom.el")
(unless (file-exists-p custom-file) (write-region "" "" custom-file))
(load custom-file)

;; === CONCAT ===
;; Content below the previous comment will be replaced with inlined elisp files for the copy of this on https://mhjones.org/emacs.
;; Concatenation is performed via the concat_emacs_config.py script
;; This lets me set up a machine by running 'curl -o .emacs https://mhjones.org/emacs'
(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))
