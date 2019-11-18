# -*- mode: shell-script; -*-

if [[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# PS1 is "(remote host name)? (directory) ([non-zero exit code])? $"
export PS1="\[\033[0;32m\]\W\[\033[00m\] \$(exit_code="\$?"; ((\$exit_code)) && echo \"\[\033[0;31m\][\$exit_code] $\" || echo \"\[\033[0;32m\]$\" )\[\033[00m\] "
if [[ "$(uname)" != Darwin ]]; then
    export PS1="\[\033[0;33m\]\h\[\033[00m\] $PS1"
fi

export PATH=$HOME/bin:$PATH:/usr/local/go/bin:bin:$HOME/Library/Python/3.7/bin:$HOME/Library/Python/2.7/bin:$HOME/go/bin
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

alias ls="ls -G"


if [[ $(command -v emacsclient) ]]; then
    export EDITOR="emacsclient -ta '' -s $HOME/.emacs.d/server/server"
elif [[ $(command -v emacs) ]]; then
    echo "Setting EDITOR to emacs"
    export EDITOR="emacs"
elif [[ $(command -v subl) ]]; then
    echo "Setting EDITOR to subl -w"
    export EDITOR="subl -w"
elif [[ $(command -v atom-beta) ]]; then
    export EDITOR="atom-beta -w"
elif [[ $(command -v atom) ]]; then
    export EDITOR="atom -w"
elif [[ $(command -v vim) ]]; then
    echo "Setting EDITOR to vim"
    export EDITOR="vim"
fi

case "$INSIDE_EMACS" in
    *term*)
	export EDITOR="emacsclient -s $HOME/.emacs.d/server/server"
esac

alias g=git
alias gg="git grep"

alias onepage='head -n $(echo "$(tput lines) - 2" | bc)'

e() {
    $EDITOR "$@"
}

shopt -s histappend
export HISTFILESIZE=100000

# Write history after each command
_bash_history_append() {
    builtin history -a
}
PROMPT_COMMAND="_bash_history_append; $PROMPT_COMMAND"

export PYTHONIOENCODING=UTF-8

for src in ~/.bash_includes/*; do
    # shellcheck source=/dev/null
    . "$src"
done

export PATH="$HOME/.cargo/bin:$PATH"
