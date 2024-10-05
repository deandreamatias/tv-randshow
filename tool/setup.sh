#!/bin/bash

clean="flutter clean"
pub_get="flutter pub get"
build_runner="dart run build_runner build --delete-conflicting-outputs"

$clean && $pub_get && $build_runner

