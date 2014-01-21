_go()
{
    COMPREPLY=()

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ ${prev} == "get" ]] && [[ -d src ]]; then
        COMPREPLY=( $(compgen -W "$(find src/* -type d | sed 's/src\///')" -- ${cur}))
        return 0
    fi
}

complete -F _go go