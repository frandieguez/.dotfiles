#!/bin/sh

# ---
# Pipes papertrail result through lnav.
# ---
function pt() {
  papertrail "$@" | lnav
}
