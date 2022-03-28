all: emacs emacs-compile

emacs:
	/Applications/Emacs.app/Contents/MacOS/Emacs --batch --eval "(setq vc-follow-symlinks nil byte-compile-current-file t)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")' --eval '(org-babel-tangle-file "~/.emacs.d/private.org")'
	/Applications/Emacs.app/Contents/MacOS/Emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --load ~/.emacs.d/private.el --exec "(straight-thaw-versions)"

emacs-compile:
	/Applications/Emacs.app/Contents/MacOS/Emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --load ~/.emacs.d/private.el --exec "(nuance/native-compile)"

update-emacs:
	/Applications/Emacs.app/Contents/MacOS/Emacs --batch --eval "(setq byte-compile-current-file t)" --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --load ~/.emacs.d/private.el --eval "(nuance/update-versions)"

clean:
	rm -rf $$HOME/.emacs.d/eln-cache $$HOME/.emacs.d/straight
