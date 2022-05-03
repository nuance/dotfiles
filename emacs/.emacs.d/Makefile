all: compile

.PHONY: org clean compile update

org:
	emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(straight-thaw-versions)"

update:
	emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/update-versions)"

compile: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/native-compile)"

update: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/update-versions)"

clean:
	rm -rf straight/build straight/repos straight/build-cache.el
	rm -rf eln-cache
