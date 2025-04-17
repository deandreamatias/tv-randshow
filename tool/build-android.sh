#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Error: Need two parameters to use this command. $0 flavor(options: dev/prod) type(options: apk/appbundle)"
    exit 1
fi

flavor="$1"
type="$2"

flutter build $type --flavor $flavor -t "lib/main_$flavor.dart" --obfuscate --split-debug-info=./android/split-debug/ "--dart-define-from-file=.env/$flavor.json"

zip -r android/split-debug.zip android/split-debug/
