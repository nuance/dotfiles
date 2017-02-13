alias st='git st'

function metadata() {
    curl -s http://169.254.169.254/latest/meta-data/$1
    echo
}
