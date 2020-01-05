#!/bin/bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build appbundle --flavor prod -t lib/main_prod.dart
flutter build apk --flavor prod -t lib/main_prod.dart