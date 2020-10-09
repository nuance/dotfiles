# -*- mode: shell-script; -*-

if [[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [[ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]]; then
    # shellcheck source=/dev/null
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
    export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
export PYTHONIOENCODING=UTF-8

# PS1 is "(remote host name)? (directory) ([non-zero exit code])? $"
export PS1="\[\033[0;32m\]\W\[\033[00m\] \$(exit_code="\$?"; ((\$exit_code)) && echo \"\[\033[0;31m\][\$exit_code] $\" || echo \"\[\033[0;32m\]$\" )\[\033[00m\] "
if [[ "$(uname)" != Darwin ]]; then
    export PS1="\[\033[0;33m\]\h\[\033[00m\] $PS1"
fi

export PATH=$HOME/bin:$PATH

alias ls="ls -G"

export EDITOR=~/bin/editor

e() {
    $EDITOR "$@"
}

alias g=git
alias gg="git grep"

alias onepage='head -n $(echo "$(tput lines) - 2" | bc)'

shopt -s histappend
export HISTFILESIZE=100000

# Write history after each command
_bash_history_append() {
    builtin history -a
}
PROMPT_COMMAND="_bash_history_append; $PROMPT_COMMAND"

if [[ -d ~/.bash_includes ]]; then
    for src in ~/.bash_includes/*; do
        # shellcheck source=/dev/null
        . "$src"
    done
fi
