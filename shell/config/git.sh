# GIT STUFF

alias g="git"

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias git-things-in-develop="git log develop ^master --no-merges"

alias release="git flow release start $(date +%Y%m%d)"
