;; Functionality I miss from sublime text (primarily multiple cursor support)

(require 'multiple-cursors)
(global-set-key (kbd "s-L") 'mc/edit-lines)
(global-set-key (kbd "s-d") 'mc/mark-all-dwim)

