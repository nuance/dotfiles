all: compile

.PHONY: org clean deepclean compile update

org:
	emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")' --eval '(org-babel-tangle-file "~/.emacs.d/private.org")'

compile: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/native-compile)"

update: org
	emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(nuance/update-versions)"

clean:
	rm -rf straight/build straight/build-cache.el
	rm -rf tree-sitter
	rm -rf eln-cache

deepclean: clean
	rm -rf straight/repos
