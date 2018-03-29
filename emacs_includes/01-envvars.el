(when window-system
  (let ((path-from-shell (shell-command-to-string "/bin/bash -l -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
