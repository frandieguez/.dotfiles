#!/bin/bash

__kube_ps1()
{
    FILE=~/.kube/config
    if test -f "$FILE"; then
        # Get current context
        CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
        
        if [ -n "$CONTEXT" ]; then
            echo "☸️ ${CONTEXT}"
        fi
    fi
}