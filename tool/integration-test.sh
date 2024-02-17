#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Error: Need one parameter to use this command. $0 flavor(options: dev/prod)"
    exit 1
fi

flavor="$1"

fvm flutter test integration_test/app_test.dart --flavor $flavor "--dart-define-from-file=.env/$flavor.json"