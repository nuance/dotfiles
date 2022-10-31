all: git zsh

.PHONY: alacritty defaults emacs git ssh yabai zsh

alacritty:
	cd alacritty/.config/alacritty && python3 keybindings.py
	stow --target $$HOME --no-folding --verbose alacritty

defaults:
	defaults import 'com.apple.Terminal' defaults/terminal.plist
	defaults import 'Apple Global Domain' defaults/key-repeat.plist
	defaults import 'com.apple.desktopservices' defaults/dsstore.plist
	defaults import 'com.apple.dock' defaults/dock.plist
	mkdir -p ~/Library/KeyBindings
	cp DefaultKeyBinding.dict ~/Library/KeyBindings/

emacs:
	stow --target $$HOME --no-folding --verbose emacs

git:
	stow --target $$HOME --no-folding --verbose git

ssh:
	stow --target $$HOME --no-folding --verbose ssh

yabai:
	stow --target $$HOME --no-folding --verbose yabai

zsh:
	stow --target $$HOME --no-folding --verbose zsh
