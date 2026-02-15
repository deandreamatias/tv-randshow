#!/bin/bash

clean="flutter clean"
pub_get="flutter pub get"
build_runner="dart run build_runner build --delete-conflicting-outputs"
android_clean="rm -f -r android/.gradle && rm -f -r android/build && rm -f -r android/app/.gradle && rm -f -r android/app/build"

$android_clean && $clean && $pub_get && $build_runner

