_go()
{
    COMPREPLY=()

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ ${prev} == "-v" ]] || [[ ${prev} == "-race" ]]; then 
        prev="${COMP_WORDS[COMP_CWORD-2]}"
    fi

    if [[ ${prev} == "go" ]]; then
        COMPREPLY=( $(compgen -W "build clean env fix fmt get install list run test tool version vet generate" -- ${cur}))
    fi

    if [[ "get install build test generate" =~ ${prev} ]] && [[ -d $GOPATH/src ]]; then
        COMPREPLY=( $(compgen -W "$(find ${GOPATH}/src/* -type d | sed 's/^.*\/src\///')" -- ${cur}))
        return 0
    fi
}

complete -F _go go