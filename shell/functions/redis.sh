# List all redis-keys
function redis-list() {
      redis-cli keys "*";

}

# Search keys by pattern
function redis-search() {
      redis-list | grep $1;

}

# Delete keys by pattern
function redis-delete() {
      redis-search $1 | xargs redis-cli del;

}

# Alias
alias rdl='redis-list'
alias rds='redis-search'
alias rdd='redis-delete'
alias rdf='redis-cli flushall'
