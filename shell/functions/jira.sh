#!/bin/sh

function jira-extract() {
    field=`jira $1 | ag ^$2: | sed -e "s/$2:\s\+//g"`

    echo $1: $field
    echo $1: $field | xclip -selection c
}

function jira-summary() {
    jira-extract $1 summary
}

alias ja="jira assign"
alias jaw="jira add worklog"
alias jc="jira create"
alias jl="jira list"
alias js="jira-summary"
alias jtd="jira trans 'Done'"
alias jtnf="jira trans Won't fix"
alias jtp="jira trans 'In development'"
alias jtqa="jira trans 'Waiting for QA'"
alias jtqa="jira trans 'Waiting for deployment'"
alias jlwd="jira list -q \"status = 'Waiting for deployment'\""
alias jlmine="jira list -q 'resolution = Unresolved AND assignee = frandieguez'"
alias jowd="jlwd|awk -F \":\" '{ print \"jira -b \" \$1 }'|sh"
alias jlqa="jira list -q 'status = \'Waiting for QA\' AND assignee = frandieguez'"
alias jlmine="jira list -q 'assignee = frandieguez'"
