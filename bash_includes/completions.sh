complete -W "$(echo $(egrep '^(ssh|sp) ' .bash_history | sort -u | sed 's/^ssh //' | sed 's/^sp //'))" ssh
complete -W "$(echo $(egrep '^(ssh|sp) ' .bash_history | sort -u | sed 's/^ssh //' | sed 's/^sp //'))" sp
complete -W "$(echo $(egrep '^s3cmd ' .bash_history | sort -u | sed 's/^s3cmd //'))" s3cmd

complete -W "$(echo $(ls -d ~/*.virt | cut -f4 -d'/' | sed 's/.virt//'))" v
