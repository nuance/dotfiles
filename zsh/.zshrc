[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

typeset -U path cdpath fpath manpath

# Use emacs keymap as the default.
bindkey -e

# Environment variables
export CLICOLOR="1"
export EMACS_SERVER_FILE="$HOME/.emacs.d/server"
export EDITOR="emacsclient"
export PROMPT="%F{green}%1~%f %(?.%F{green}.%F{red}[%?] )$%f "
export PYTHONIOENCODING="UTF-8"
export SSH_AUTH_SOCK="/Users/matt/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"
HISTORY_IGNORE='(ls|cd|exit)'
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

function setup-remote-host () {
    hostname=$1; shift;

    scp -q ~/.config/git/config $hostname:.gitconfig
    scp -q ~/.remote/remote-profile $hostname:.remote-profile
    scp -q ~/.remote/remote-editor $hostname:.remote-editor
    scp -q ~/.emacs/server $hostname:.remote-emacs-server
    ssh $hostname mkdir -p bin

    ssh $hostname "
        [[ -e .bash_profile ]] || ( echo -n 'Creating .bash_profile... '; cat > .bash_profile <<EOF && echo ok )
# -*- mode: sh -*-

# include .profile if it exists
[[ -f ~/.profile ]] && . ~/.profile

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc
EOF
"
      ssh $hostname "
        [[ \$(grep REMOTE-EDITOR ~/.bash_profile) ]] || ( echo -n 'Adding .remote-profile to .bash_profile... '; cat >> .bash_profile <<EOF && echo ok )
# start REMOTE-EDITOR
[[ -f ~/.remote-profile ]] && . ~/.remote-profile
# end REMOTE-EDITOR
EOF
"
    }

eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias e='$EDITOR'
alias en='$EDITOR -n'
alias g='git'
alias gg='git grep'
alias onepage='head -n $(echo "$(tput lines) - 2" | bc)'
