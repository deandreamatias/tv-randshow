fvm flutter clean &&
    fvm flutter pub get &&
    fvm dart run build_runner build --delete-conflicting-outputs
