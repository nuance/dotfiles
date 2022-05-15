all: homebrew stow secrets.json emacs defaults

.PHONY: homebrew homebrew-install homebrew-bundle stow emacs defaults clean update update-homebrew update-emacs

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

emacs: stow
	cd ~/.emacs.d && make

update-homebrew: homebrew
	command brew update
	command brew upgrade
	command brew bundle

update-emacs: emacs
	cd ~/.emacs.d && make update

update: update-homebrew update-emacs

defaults:
	defaults import 'com.apple.Terminal' defaults/terminal.plist
	defaults import 'Apple Global Domain' defaults/key-repeat.plist
	defaults import 'com.apple.desktopservices' defaults/dsstore.plist
	defaults import 'com.apple.dock' defaults/dock.plist

clean: homebrew
	for dir in $$(find . -type d -not -path "./.git" -and -not -path "./.github" -mindepth 1 -maxdepth 1); do if [ ! -e $$dir/.nostow ]; then stow -v -D $${dir#*/}; fi; done
	rm ~/Library/KeyBindings/DefaultKeyBinding.dict
	rm -rf $$HOME/.emacs.d
