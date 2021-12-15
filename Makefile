all: homebrew stow secrets.json emacs

.PHONY: homebrew homebrew-install homebrew-bundle stow emacs clean
secrets.json: generate-secrets.py
	python3 generate-secrets.py
	rm .git/index
	git checkout HEAD -- .

homebrew: homebrew-install homebrew-bundle

homebrew-install:
	command -v brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

homebrew-bundle: Brewfile
	/opt/homebrew/bin/brew bundle

stow: homebrew DefaultKeyBinding.dict
	for dir in $$(find . -type d -not -path "./.git/*" -mindepth 2); do mkdir -p ~/$${dir#*/*/}; done
	for dir in $$(find . -type d -not -path "./.git" -mindepth 1 -maxdepth 1); do stow -v $${dir#*/}; done
	cp DefaultKeyBinding.dict ~/Library/KeyBindings/

emacs: emacs/.emacs.d/init.org stow
	/opt/homebrew/bin/emacs --batch --eval "(setq vc-follow-symlinks nil)" --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
	/opt/homebrew/bin/emacs --batch --load ~/.emacs.d/early-init.el --load ~/.emacs.d/init.el

clean: homebrew
	for dir in $$(find . -type d -not -path "./.git" -mindepth 1 -maxdepth 1); do stow -v -D $${dir#*/}; done
	rm ~/Library/KeyBindings/DefaultKeyBinding.dict
