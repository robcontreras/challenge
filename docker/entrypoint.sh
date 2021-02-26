#!/bin/bash

set -e

# remove any hanging pids
FILE=tmp/pids/server.pid
if test -f "$FILE"; then
    rm -f tmp/pids/server.pid
fi
bundle install

exec "$@"
