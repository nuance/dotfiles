all: homebrew stow secrets.json emacs emacs-compile defaults

.PHONY: homebrew homebrew-install homebrew-bundle stow emacs defaults clean update update-emacs update-homebrew reinstall-emacs refresh-emacs

secrets.json: generate-secrets.py
	python3 generate-secrets.py
	git stash
	rm .git/index
	git checkout HEAD -- .
	git stash apply

homebrew: homebrew-install homebrew-bundle

homebrew-install:
	command -v brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

homebrew-bundle: Brewfile
	command brew bundle

stow: homebrew DefaultKeyBinding.dict
	for dir in $$(find . -type d -not -path "./.git" -and -not -path "./.github" -mindepth 1 -maxdepth 1); do if [ ! -e $$dir/.nostow ]; then stow --target $$HOME --no-folding --verbose $${dir#*/}; fi; done
	mkdir -p ~/Library/KeyBindings
	cp DefaultKeyBinding.dict ~/Library/KeyBindings/

emacs: emacs/.emacs.d/init.org stow
	$$(command brew --prefix)/bin/emacs --batch --eval "(setq vc-follow-symlinks nil)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(straight-thaw-versions)"

emacs-compile: emacs
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --exec "(setq native-comp-deferred-compilation t)" --exec "(setq native-comp-async-jobs-number 16)" --exec "(native-compile-async \"$$HOME/.emacs.d/straight/build\" 'recursively)" --exec "(while (and comp-files-queue (> (comp-async-runnings) 0)) (progn (message \"comp-files-queue: %s | comp-async-runnings: %d\" (and comp-files-queue (length comp-files-queue)) (comp-async-runnings)) (sleep-for 1)))"

update-emacs: emacs
	$$(command brew --prefix)/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el --eval "(straight-pull-all)" --eval "(straight-freeze-versions)"

update-homebrew: homebrew
	command brew update
	command brew upgrade
	command brew bundle

update: update-homebrew update-emacs

reinstall-emacs: homebrew
	command brew reinstall

refresh-emacs: reinstall-emacs update-emacs emacs-compile

defaults:
	defaults import 'com.apple.Terminal' defaults/terminal.plist
	defaults import 'Apple Global Domain' defaults/key-repeat.plist
	defaults import 'com.apple.desktopservices' defaults/dsstore.plist
	defaults import 'com.apple.dock' defaults/dock.plist

clean: homebrew
	for dir in $$(find . -type d -not -path "./.git" -and -not -path "./.github" -mindepth 1 -maxdepth 1); do if [ ! -e $$dir/.nostow ]; then stow -v -D $${dir#*/}; fi; done
	rm ~/Library/KeyBindings/DefaultKeyBinding.dict
	rm -rf $$HOME/.emacs.d
