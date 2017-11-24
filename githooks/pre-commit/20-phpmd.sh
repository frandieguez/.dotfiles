#!/bin/bash

# This hook executes phpmd tests in a project if a phpmd.xml file is found
# in the project root directory.

# Get name of the project (probably topmost directory name).
projectname=${PWD##*/}

staged=`git diff --diff-filter=AM --cached --name-only | grep "\.php$"`

# Nothing to do
if [[ $staged = '' ]]; then
    exit 0
fi

# Nothing to do
if [[ ! -f phpmd.xml ]]; then
    exit 0
fi


# Locate our phpmd.
phpmd=`which phpmd`

# Any extra arguments to phpmd should go here.
phpmd_args="text phpmd.xml"

# Define a location to save the output.
outputlog="/tmp/phpmd_output_`date +%s`.log"
returnCode=0

echo -e -n "\033[1m==> Executing code checking...\033[0m "

# Execute code checking. (Assume that phpmd.xml is in root of project).
for file in ${staged[@]}; do
    ${phpmd} ${file} ${phpmd_args} >> $outputlog
    returnCode=$(($returnCode + $?))
done;

# if unit tests fail, output a summary and exit with failure code.
if [ $returnCode -eq 0 ]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

issues=`echo "$output" | wc -l`
issue="issues"

if [[ "issues" != "0" ]]; then
    echo -e "\E[33;5mWARNING\033[0m"
fi

# output the status.
echo -e "phpmd output saved in \E[34;5m${outputlog}\033[0m"
echo -e "\E[33;5mCoding style issues found ($issues issues) found in:\033[0m"

for file in ${staged[@]}; do
    echo -e " \E[34;5m$file\033[0m"
done;
