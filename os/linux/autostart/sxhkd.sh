#!/bin/sh
# ---
# This script launches the sxhkd daemon in background.
# ---

killall sxhkd > /dev/null 2>&1

sxhkd > /dev/null 2>&1 &
