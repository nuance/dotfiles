all: compile

.PHONY: org clean deepclean compile update

org:
	emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")' --eval '(org-babel-tangle-file "~/.emacs.d/private.org")'
	emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(straight-thaw-versions)"

compile: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/native-compile)"

update: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/update-versions)"

freeze: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(straight-freeze-versions)"

clean:
	rm -rf straight/build straight/build-cache.el
	rm -rf eln-cache

deepclean: clean
	rm -rf straight/repos
