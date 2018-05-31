(use-package org
  :config
  (setq org-log-done t
	;; refile-related configs from https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
	org-refile-targets '((org-agenda-files :maxlevel . 3))
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-allow-creating-parent-nodes 'confirm
	org-startup-folded t))
