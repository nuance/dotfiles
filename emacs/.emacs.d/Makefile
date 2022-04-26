all: compile

.PHONY: org clean compile

org:
	$$(command brew --prefix)/bin/emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(straight-thaw-versions)"

update:
	$$(command brew --prefix)/bin/emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/update-versions)"

compile: org
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --eval "(setq byte-compile-current-file t)" --exec "(setq native-comp-deferred-compilation t)" --exec "(setq native-comp-async-jobs-number 16)" --exec "(native-compile-async \"$$HOME/.emacs.d/straight/build\" 'recursively)" --exec "(while (and comp-files-queue (> (comp-async-runnings) 0)) (progn (message \"comp-files-queue: %s | comp-async-runnings: %d\" (and comp-files-queue (length comp-files-queue)) (comp-async-runnings)) (sleep-for 1)))"

clean:
	rm -rf straight/build straight/repos straight/build-cache.el
	rm -rf eln-cache
