#!/bin/bash

function oppi_release() {
    if [[ $1 == '' ]]; then
        echo 'You must pass a deployment ticket'
        return 1
    fi
    jira trans Deployed $1
    jira edit --noedit -o onmenv=prod  $1
    oppi deploy release $1
}
