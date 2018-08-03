#!/bin/sh

# Get values for the list of keys
function redis_get() {
    keys=($(redis_search $1))
    i=1;

    for key in $keys; do
        if [[ $i -gt 1 ]]; then
            echo ""
        fi

        echo $i")" $key
        redis-cli get $key
        i=$(( $i + 1 ))
    done;
}

# List all redis_keys
function redis_list() {
    redis-cli keys "*"
}

# Search keys by pattern
function redis_search() {
    redis_list | grep $1
}

# Delete keys by pattern
function redis_delete() {
    redis_search $1 | xargs redis-cli del
}

# Alias
alias rdd='redis_delete'
alias rdf='redis-cli flushall'
alias rdg='redis_get'
alias rdl='redis_list'
alias rds='redis_search'
