#!/bin/sh

function jira_done_all() {
    tickets=`jira $1 | sed -e "/.*\(\(ONM\|OT\)-[0-9]\+\).*/!d" -e "s/.*\(\(ONM\|OT\)-[0-9]\+\).*/\1/g" | sort | uniq`

    for i in `echo "$tickets"`; do
        jira trans 'Done' --noedit $i
    done
}

function jira_extract() {
    field=`jira $1 | ag ^$2: | sed -e "s/$2:\s\+//g"`

    echo $1 $field
    echo $1 $field | xclip -selection c
}

function jira_extract_summary() {
    jira_extract $1 summary
}

function jira_list_and_extract() {
    tickets=`jira list -q "$1" | sed -e "s/:\s\+/ /g"`

    echo $tickets
    echo $tickets | xclip -selection c
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
        tail -n +4 | head -n -3 | sed -e "s/\s\+|\s\+/|/g" | \
        grep "[A-Z]\+[0-9]\+"`;

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
        tail -n +4 | head -n -3 | sed -e "s/\s*|\s*/|/g" | \
        grep "[A-Z]\+-[0-9]\+"`;
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
alias jlcd="jira_list_and_extract \"project = ONM AND status = 'Waiting for deployment' AND (labels IS EMPTY OR labels != themes) ORDER BY key ASC\""
alias jlqa="jl -q \"assignee = currentUser() AND status = 'Waiting for QA'\""
alias jltd="jira_list_and_extract \"project = ONM AND status = 'Waiting for deployment' AND type != Deployment AND labels = themes ORDER BY key ASC\""
alias js="jira_extract_summary"
alias jtd="jira trans 'Done' --noedit"
alias jtda="jira_done_all"
alias jtnf="jira trans 'Won\'t fix' --noedit"
alias jtid="jira trans 'In development' --noedit"
alias jtqa="jira trans 'Waiting for QA' --noedit"
alias jtm="jira trans 'Waiting for release' --noedit"
alias jtwd="jira trans 'Waiting for deployment' --noedit"
