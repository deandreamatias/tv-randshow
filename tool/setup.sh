#!/bin/bash

clean="flutter clean"
pub_get="flutter pub get"
build_runner="dart run build_runner build --delete-conflicting-outputs"

# Check if fvm is installed
if command -v fvm &> /dev/null; then
    fvm doctor &&
        fvm $clean &&
        fvm $pub_get &&
        fvm $build_runner
else
    $clean &&
        $pub_get &&
        $build_runner
fi

