# Get values for the list of keys

command -v redis-cli || return;

function redis-get() {
  keys=($(redis-search $1))
  i=1;

  for key in $keys; do
    if [[ $i -gt 1  ]]; then
      echo "";
    fi

    echo $i")" $key
    redis-cli get $key
    i=$(( $i + 1  ))
  done;

}

# List all redis-keys
function redis-list() {
  redis-cli keys "*"

}

# Search keys by pattern
function redis-search() {
  redis-list | grep $1

}

# Delete keys by pattern
function redis-delete() {
  redis-search $1 | xargs redis-cli del

}

# Alias
alias rdd='redis-delete'
alias rdf='redis-cli flushall'
alias rdg='redis-get'
alias rdl='redis-list'
alias rds='redis-search'
