#!/bin/bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build appbundle --obfuscate --split-debug-info=/tv-randshow/split-debug --flavor prod -t lib/main_prod.dart
flutter build apk --obfuscate --split-debug-info=/tv-randshow/split-debug --flavor prod -t lib/main_prod.dart