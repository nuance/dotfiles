#!/bin/sh

# install homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# install brew cask for apps
brew tap phinze/cask
brew tap jingweno/gh

# install default packages
brew install brew-cask gh git jq pypy rlwrap s3cmd tmux tree wget

# install apps
brew cask install alfred arq charles cinch colloquy dropbox fantastical flux hipchat iterm2-beta marked2 rdio skype steam tunnelblick-beta virtualbox
