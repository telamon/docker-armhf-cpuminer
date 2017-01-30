#!/bin/sh
if [ -z "$@" ]; then
  exec minerd -o $STRATUM_URL -u $USERNAME -p $PASSWORD
else
  exec $@
fi
