;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)
(setq cursor-type 'hbar)

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
