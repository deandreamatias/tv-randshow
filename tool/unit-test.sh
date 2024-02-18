#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Error: Need one parameter to use this command. $0 flavor(options: dev/prod)"
    exit 1
fi

flavor="$1"

command="flutter test "--dart-define-from-file=.env/$flavor.json" --test-randomize-ordering-seed random"

if command -v fvm &> /dev/null; then
    fvm $command
else
    $command
fi