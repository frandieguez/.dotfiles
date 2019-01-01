#!/bin/bash

# This hook checks if commit messages has a valid JIRA issue included or if
# they refer to a merge.

echo -e -n "\033[1m==> Checking commit message...\033[0m "

if [[ `grep -iE "([A-Z]{3,}-[0-9]{1,}:\s+.*|.*merge.+)" "$1"` != "" ]]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

echo -e "\E[31;5mFAIL\033[0m"
echo -e "\033[1m\E[47;41mABORTING COMMIT\033[0m"
exit -1
