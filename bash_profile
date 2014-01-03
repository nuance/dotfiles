export PS1="\[\033[0;32m\]\W\[\033[00m\] \[\033[0;31m\]\$\[\033[00m\] "
if [ $(hostname) != "Macintosh.local" ]; then
    export PS1="\h $PS1"
fi

export PATH=/usr/local/bin:$PATH:$HOME/bin:/usr/local/go/bin:bin
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export CC=gcc-4.2

alias ls="ls -G"

if [[ $(which subl) ]]; then
    export EDITOR="subl -w"
elif [[ $(which emacs) ]]; then
    echo "Setting EDITOR to emacs"
    export EDITOR="emacs"
elif [[ $(which vim) ]]; then
    echo "Setting EDITOR to vim"
    export EDITOR="vim"
fi

if [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
    export HADOOP_HOME="/usr/local/Cellar/hadoop/1.2.1/libexec/"
fi

if [[ $(which hub) ]]; then
    eval "$(hub alias -s)"
fi

alias g=git
alias gg="git grep"
alias docker.vagrant='docker -H localhost:4243'
alias docker.married='docker -H localhost:4244'

alias e="$EDITOR"

shopt -s histappend
export HISTFILESIZE=100000

function check() {
    echo "** pep8 **"
    pep8 --show-source --max-line-length=120 $*
    echo "** pyflakes **"
    pyflakes $*
}

if [[ $(which src-hilite-lesspipe.sh) ]]; then
    LESSPIPE=`which src-hilite-lesspipe.sh`
elif [[ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
    LESSPIPE="/usr/share/source-highlight/src-hilite-lesspipe.sh"
fi

if [[ LESSPIPE != "" ]]; then
    export LESSOPEN="| ${LESSPIPE} %s"
    export LESS='-R'
fi

for src in `ls ~/.bash_includes`; do
    source ~/.bash_includes/$src
done