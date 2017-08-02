#!/bin/bash

# This hook executes phpunit tests in a project if a phpunit.xml file is found
# in the project root directory.

# Get name of the project (probably topmost directory name).
projectname=${PWD##*/}

# Nothing to do
if [[ ! -f phpunit.xml ]]; then
    exit 0
fi

# Locate our phpunit.
phpunit=`which phpunit`

# Any extra arguments to phpunit should go here.
phpunit_args=""

# Define a location to save the output.
outputlog="/tmp/phpunit_output_`date +%s`.log"

echo -e -n "\033[1m==> Executing unit tests...\033[0m "

# execute unit tests. (Assume that phpunit.xml is in root of project).
output=`${phpunit} ${phpunit_args}`
returnCode=$?

# Save the output of phpunit for posterity.
echo "$output" > $outputlog

# if unit tests fail, output a summary and exit with failure code.
if [ $returnCode -eq 0 ]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

# find the line with the summary.
while read -r line; do
  if [[ $line =~ Errors: || $line =~ Failures: ]] ; then
    summary=$line
    break
  fi
done <<< "$output"

# output the status.
echo -e "\E[31;5mFAIL\033[0m"
echo -e "PHPUnit output saved in \E[34;5m${outputlog}\033[0m"
echo -e "$summary\033[0m"

# Abort the commit.
echo -e "\033[1m\E[47;41mABORTING COMMIT\033[0m"
exit $returnCode
