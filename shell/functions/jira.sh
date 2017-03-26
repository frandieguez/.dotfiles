#!/bin/sh

function jira_extract() {
    field=`jira $1 | ag ^$2: | sed -e "s/$2:\s\+//g"`

    echo $1: $field
    echo $1: $field | xclip -selection c
}

function jira_extract_summary() {
    jira_extract $1 summary
}

function jira_log_activity() {
    id=`echo $1 | cut -d'|' -f4`
    comment=`echo $1 | cut -d'|' -f6`

    date=`echo $1 | cut -d'|' -f1`
    date=`date -d "$date+0100" +"%Y-%m-%dT%H:%M:%S.%3N%z"`;

    duration=`echo $1 | cut -d'|' -f3 | sed -e "s/min/m/g"`

    echo "$id - $date - $duration - $comment"

    echo "comment: |~" > /tmp/jira-template.tmp;
    echo "    $comment" >> /tmp/jira-template.tmp;
    echo "timeSpent: $duration" >> /tmp/jira-template.tmp;
    echo "started: $date" >> /tmp/jira-template.tmp;

    jira add worklog $id -t /tmp/jira-template.tmp --noedit;
}

function jira_log_day() {
    SAVEIFS=$IFS;
    IFS=$(echo -en "\n\b");

    activities=`hamster search '' $1 | \
        sed -e ':a' -e 'N' -e '$!ba' -e "s/\n\s\+/|/g" | \
        tail -n +4 | head -n -3 | sed -e "s/\s\+|\s\+/|/g"`;

    for activity in `echo $activities`; do
        jira_log_activity "$1 $activity"
    done

    IFS=$SAVEIFS
}

function jira_log_from_to() {
    SAVEIFS=$IFS;
    IFS=$(echo -en "\n\b");

    activities=`hamster search '' $1 $2 | \
        sed -e ':a' -e 'N' -e '$!ba' -e "s/\n\s\+/|/g" | \
        tail -n +4 | head -n -3 | sed -e "s/\s*|\s*/|/g"`;
    echo $activities

    for activity in `echo $activities`; do
        jira_log_activity $activity
    done

    IFS=$SAVEIFS
}

function jira_log_week() {
    start=`date -d "- $(date +%u) days + 1 day" +%Y-%m-%d`;
    end=`date -d "+ 7 days - $(date +%u) days" +%Y-%m-%d`;

    jira_log_from_to $start $end
}

alias ja="jira assign"
alias jaw="jira add worklog"
alias jawd="jira_log_day"
alias jawft="jira_log_from_to"
alias jawt="jira_log_day $(date +%Y-%m-%d)";
alias jaww="jira_log_week"
alias jc="jira create"
alias jl="jira list"
alias js="jira_extract_summary"
alias jtd="jira trans 'Done' --noedit"
alias jtnf="jira trans 'Won\'t fix' --noedit"
alias jtp="jira trans 'In development' --noedit"
alias jtqa="jira trans 'Waiting for QA' --noedit"
alias jtwd="jira trans 'Waiting for deployment' --noedit"

alias jlmine="jira list -q 'resolution = Unresolved AND assignee = frandieguez'"
alias jowd="jlwd|awk -F \":\" '{ print \"jira -b \" \$1 }'|sh"
alias jlwd="jira list -q \"status = 'Waiting for deployment'\""
alias jlqa="jira list -q 'status = \'Waiting for QA\' AND assignee = frandieguez'"
