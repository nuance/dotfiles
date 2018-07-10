(use-package org
  :config
  (setq org-log-done t
	;; refile-related configs from https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
	org-refile-targets '((org-agenda-files :maxlevel . 3))
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-allow-creating-parent-nodes 'confirm
	org-startup-folded t)
  ;; custom todo tags
  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "CANCELED(c@)")
	  (sequence "MEET(m@)" "|" "DONE(d!)")
	  (sequence "IDEA(a)" "|" "DONE(d!)")))
  (setq org-agenda-custom-commands
	'(("d" "Daily agenda and all TODOs"
           ((todo "IN-PROGRESS"
		  ((org-agenda-overriding-header "Unfinished tasks:")))
            (agenda "" ((org-agenda-span 1)))
            (todo "TODO"
		  ((org-agenda-overriding-header "Open tasks:")))
            (todo "MEET"
		  ((org-agenda-overriding-header "People to meet:")
		   (org-agenda-max-entries 5)))
            (todo "IDEA"
		  ((org-agenda-overriding-header "Ideas:")
		   (org-agenda-max-entries 5))))
           ((org-agenda-compact-blocks t))))))
