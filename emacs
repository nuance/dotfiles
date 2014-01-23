;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

(setq inhibit-startup-echo-area-message "matt")

(if (boundp 'toggle-frame-fullscreen) (toggle-frame-fullscreen))
(if (boundp 'scroll-bar-mode) (scroll-bar-mode 0))
(if (boundp 'tool-bar-mode) (tool-bar-mode 0))
(if (boundp 'menu-bar-mode) (menu-bar-mode 0))

