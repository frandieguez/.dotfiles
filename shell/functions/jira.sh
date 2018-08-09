#!/bin/sh

command -v jira || return

eval "$(jira --completion-script-bash)"

# ---
# Check an issue description and mark all tickets included.
#
# @param $1 The issue key.
# ---
function jira_done_all() {
    tickets=`jira $1 | sed -e "/.*\(\(ONM\|OT\)-[0-9]\+\).*/!d" \
        -e "s/.*\(\(ONM\|OT\)-[0-9]\+\).*/\1/g" | sort | uniq`

    for i in `echo "$tickets"`; do
        jira trans 'Done' --noedit $i
    done
}

# ---
# Extracts a field from an issue.
#
# @param $1 The issue key.
# @param $2 The field to extract.
# ---
function jira_extract() {
    field=`jira $1 | ag ^$2: | sed -e "s/$2:\s\+//g"`

    echo $1 $field
    echo $1 $field | xclip -selection c
}

# ---
# Extract a summary from an issue.
#
# @param $1 The issue key.
# ---
function jira_extract_summary() {
    jira_extract $1 summary
}

# ---
# Searches issues and copies the result to the clipboard.
#
# @param $1 The criteria to search by.
# ---
function jira_list_and_extract() {
    tickets=`jira list -q "$1" | sed -e "s/:\s\+/ /g"`

    echo $tickets
    echo $tickets | xclip -selection c
}

# ---
# Adds a worklog to an issue.
#
# @param $1 The worklog information as "starttime|endtime|time|key|project"
# ---
function jira_log_activity() {
    echo "activity: $1"
    id=`echo $1 | cut -d'|' -f4`
    comment=`echo $1 | cut -d'|' -f6`

    date=`echo $1 | cut -d'|' -f1`
    date=`date -d "$date+0100" +"%Y-%m-%dT%H:%M:%S.%3N%z"`;

    duration=`echo $1 | cut -d'|' -f3 | sed -e "s/min/m/g"`

    echo "$id - $date - $duration - $comment"

    echo "comment: |~" > ~/.jira.d/templates/jira-template.tmp;
    echo "    $comment" >> ~/.jira.d/templates/jira-template.tmp;
    echo "timeSpent: $duration" >> ~/.jira.d/templates/jira-template.tmp;
    echo "started: $date" >> ~/.jira.d/templates/jira-template.tmp;

    jira worklog add $id -t jira-template.tmp --noedit
}

# ---
# Logs all work stored in project hamster for a date to JIRA.
#
# @param $1 The date to log.
# ---
function jira_log_day() {
    SAVEIFS=$IFS;
    IFS=$(echo -en "\n\b");

    activities=`hamster search '' $1 | \
        sed -e ':a' -e 'N' -e '$!ba' -e "s/\n\s\+/|/g" | \
        tail -n +4 | head -n -3 | sed -e "s/\s*|\s*/|/g" | \
        grep "[A-Z]\+-[0-9]\+"`;

    for activity in `echo $activities`; do
        jira_log_activity $activity
    done

    IFS=$SAVEIFS
}

# ---
# Logs all work stored in project hamster between two dates.
#
# @param $1 The start date.
# @param $1 The end date.
# ---
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

# ---
# Logs all work done in the current week.
# ---
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
alias jlcd="jira_list_and_extract \"project = ONM AND status = 'In pre' AND (labels IS EMPTY OR labels != themes) ORDER BY key ASC\""
alias jlqa="jl -q \"assignee = currentUser() AND status = 'In pre'\""
alias jltd="jira_list_and_extract \"project = ONM AND status = 'In pre' AND type != Deployment AND labels = themes ORDER BY key ASC\""
alias js="jira_extract_summary"
alias jtd="jira trans 'Done' --noedit"
alias jtda="jira_done_all"

alias jlmine="jira list -q 'resolution = Unresolved AND assignee = frandieguez'"
alias jowd="jlwd|awk -F \":\" '{ print \"jira -b \" \$1 }'|sh"
alias jlwd="jira list -q \"status = 'Waiting for deployment'\""
alias jlqa="jira list -q 'status = \'Waiting for QA\' AND assignee = frandieguez'"
