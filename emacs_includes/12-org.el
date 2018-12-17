(use-package org
  :config
  (setq org-log-done t
	;; refile-related configs from https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
	org-refile-targets '((org-agenda-files :maxlevel . 3))
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-allow-creating-parent-nodes 'confirm
	org-startup-folded t
	org-agenda-log-mode-items '(closed clock state))
  ;; custom todo tags
  (setq org-todo-keywords
	'((sequence "TODO(t!)" "IN-PROGRESS(i@/!)" "|" "DONE(d!)" "CANCELED(c@!)")
	  (sequence "MEET(m@)" "|" "DONE(d!)")
	  (sequence "IDEA(a!)" "|" "DONE(d!)")))
  (setq org-agenda-custom-commands
	'(("d" "Daily agenda and all TODOs"
           ((todo "IN-PROGRESS"
		  ((org-agenda-overriding-header "Unfinished tasks:")))
            (agenda "" ((org-agenda-span 1)))
	    (tags ":refile:"
		  ((org-agenda-overriding-header "To refile:")))
            (todo "TODO"
		  ((org-agenda-overriding-header "Open tasks:")))
            (todo "MEET"
		  ((org-agenda-overriding-header "People to meet:")
		   (org-agenda-max-entries 5)))
            (todo "IDEA"
		  ((org-agenda-overriding-header "Ideas:")
		   (org-agenda-max-entries 5))))
           ((org-agenda-compact-blocks t)))
	  ("p" "3-week context plan"
           ((agenda "" ((org-agenda-start-day "-7d") (org-agenda-span 21))))
	   ((org-agenda-compact-blocks t)
	    (org-agenda-include-inactive-timestamps 't)))))
  (setq helm-org-ignore-autosaves t
	helm-org-headings-fontify t
	helm-org-format-outline-path t
	helm-org-show-filename t
	helm-org-headings-max-depth 5)
  :bind (:map org-mode-map ("s-r" . helm-org-agenda-files-headings)))
