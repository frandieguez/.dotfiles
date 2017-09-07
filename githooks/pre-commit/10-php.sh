#!/bin/bash

# This hook checks php syntax in staged files and aborts the commit when one
# or more errors are found.

staged=`git diff --cached --name-only | grep ".php$"`

# Nothing to do
if [[ $staged = '' ]]; then
    exit 0
fi

echo -e -n "\033[1m==> Checking PHP syntax in staged files...\033[0m "

files=()
counter=0
for file in $staged; do
    if [[ -f $file && ! `php -l $file 2>&1` =~ 'No syntax errors detected' ]]; then
        counter=$((counter + 1))
        files+=($file)
    fi
done

if [[ $counter = 0 ]]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

echo -e "\E[31;5mFAIL\033[0m"
echo -e "\E[33;5mSyntax errors found in:\033[0m"

for file in "${files[@]}"; do
    echo -e " \E[34;5m$file\033[0m"
done;

echo -e "\033[1m\E[47;41mABORTING COMMIT\033[0m"
exit -1
