#!/bin/sh

function jira-extract() {
    field=`jira $1 | ag $2 | sed -e "s/$2:\s\+//g"`

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
