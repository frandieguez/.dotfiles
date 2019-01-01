#!/bin/bash

# This hook executes phpcs tests in a project if a phpcs.xml file is found
# in the project root directory.

# Get name of the project (probably topmost directory name).
projectname=${PWD##*/}

staged=`git diff --diff-filter=AM --cached --name-only | grep "\.js$"`

# Nothing to do
if [[ $staged = '' ]]; then
    exit 0
fi

jshint_args=""

# Any extra arguments to jshint should go here.
if [[ -f .jshintrc ]]; then
    jshint_args="-c .jshintrc"
fi

# Locate jshint.
jshint=`which jshint`

# Define a location to save the output.
outputlog="/tmp/jshint_output_`date +%s`.log"

echo -e -n "\033[1m==> Executing JS coding style checking...\033[0m "

# Execute code checking. (Assume that phpcs.xml is in root of project).
output=`${jshint} ${jshint_args} ${staged}`
returnCode=$?

# Save the output of phpcs for posterity.
echo "$output" > $outputlog

# if unit tests fail, output a summary and exit with failure code.
if [ $returnCode -eq 0 ]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

errors=`echo "$output" | grep "errors" | sed -e "s/\([0-9]\+\)\s\+errors/\1/g"`
files=`echo "$output" | grep ".*:" | sed -e "s/:.*//g" | sort | uniq`

if [[ "$errors" != "0" ]]; then
    echo -e "\E[31;5mFAIL\033[0m"
fi

# output the status.
echo -e "JSHint output saved in \E[34;5m${outputlog}\033[0m"
echo -e "\E[33;5mCoding style issues found ($errors errors) found in:\033[0m"

for file in $files; do
    echo -e " \E[34;5m$file\033[0m"
done;

if [[ "$errors" == "0" ]]; then
    exit 0
fi

# Abort the commit.
echo -e "\033[1m\E[47;41mABORTING COMMIT\033[0m"
exit $returnCode
