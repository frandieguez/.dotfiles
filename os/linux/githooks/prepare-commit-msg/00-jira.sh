#!/bin/bash

# This hook checks if the current branch includes a JIRA issue in its name and
# adds it to the commit message.

if [[ `grep -iE "[A-Z]{3,}-[0-9]{1,}:\s+.*" "$1"` != "" ]]; then
    exit 0
fi

id=`git rev-parse --abbrev-ref HEAD | grep -e "^\(feature\|hotfix\)\{1\}" | sed "s/\(feature\|hotfix\)\/\([A-Z]\+\-[0-9]\+\)\(-[0-9]\+\)*/\2/g"`

if [[ "$id" != "" ]]; then
    sed -i "1s/^/$id: /" $1
fi;
