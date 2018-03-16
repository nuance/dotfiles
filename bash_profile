# PS1 is "(remote host name)? (directory) ([non-zero exit code])? $"
export PS1="\[\033[0;32m\]\W\[\033[00m\] \$(exit_code="\$?"; ((\$exit_code)) && echo \"\[\033[0;31m\][\$exit_code] $\" || echo \"\[\033[0;32m\]$\" )\[\033[00m\] "
if [[ "$(hostname)" != *.local && "$(hostname)" != matt-MBP13-* && "$(hostname)" != *mjones ]]; then
    export PS1="\[\033[0;33m\]\h\[\033[00m\] $PS1"
fi

export PATH=$HOME/bin:$PATH:/usr/local/go/bin:bin:/Users/matt/Library/Python/2.7/bin
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

alias ls="ls -G"


if [[ $(which subl) ]]; then
    export EDITOR="subl -w"
elif [[ $(which atom-beta) ]]; then
    export EDITOR="atom-beta -w"
elif [[ $(which atom) ]]; then
    export EDITOR="atom -w"
elif [[ $(which emacs) ]]; then
    echo "Setting EDITOR to emacs"
    export EDITOR="emacs"
elif [[ $(which vim) ]]; then
    echo "Setting EDITOR to vim"
    export EDITOR="vim"
fi

if [[ $(which gh) ]]; then
    eval "$(gh alias -s)"
elif [[ $(which hub) ]]; then
    eval "$(hub alias -s)"
fi

alias g=git
alias gg="git grep"

alias onepage='head -n $(echo "$(tput lines) - 2" | bc)'

alias notes="git --git-dir=/Users/matt/Dropbox/Notes.git/.git --work-tree=/Users/matt/Dropbox/Notes"

alias e="$EDITOR"

shopt -s histappend
export HISTFILESIZE=100000

# Write history after each command
_bash_history_append() {
    builtin history -a
}
PROMPT_COMMAND="_bash_history_append; $PROMPT_COMMAND"

if [[ $(which src-hilite-lesspipe.sh) ]]; then
    LESSPIPE=`which src-hilite-lesspipe.sh`
elif [[ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
    LESSPIPE="/usr/share/source-highlight/src-hilite-lesspipe.sh"
fi

if [[ $LESSPIPE != "" ]]; then
    export LESSOPEN="| ${LESSPIPE} %s"
    export LESS='-R'
fi

export PYTHONIOENCODING=UTF-8

for src in `ls ~/.bash_includes`; do
    source ~/.bash_includes/$src
done
