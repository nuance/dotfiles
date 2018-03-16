;; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold 20000000)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

(setq inhibit-startup-echo-area-message "matt")

(if (boundp 'toggle-frame-fullscreen) (toggle-frame-fullscreen))
(if (boundp 'scroll-bar-mode) (scroll-bar-mode 0))
(if (boundp 'tool-bar-mode) (tool-bar-mode 0))
(if (boundp 'menu-bar-mode) (menu-bar-mode 0))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(mapc 'load (directory-files "~/.emacs_includes" t "^[0-9]+.*\.el$"))

(defun load-directory (dir)
  (let ((load-it (lambda (f)
		   (load-file (concat (file-name-as-directory dir) f)))
		 ))
    (mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "~/.emacs_includes")

(setq apropos-do-all t
      require-final-newline t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-delay 0.1)
 '(custom-safe-themes
   (quote
    ("ed2b5df51c3e1f99207074f8a80beeb61757ab18970e43d57dec34fe21af2433" "4eb982b248bf818a72877ecb126a2f95d71eea24680022789b14c3dec7629c1b" default)))
 '(package-selected-packages
   (quote
    (flx-ido projectile all-the-icons diff-hl company-quickhelp company-jedi smex py-yapf pyvenv flycheck multiple-cursors magit company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
