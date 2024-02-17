# Show all commands
default:
    just --list

# Show all commands
help:
    just --list

# Run project with {{flavor}}
run flavor device:
    fvm flutter run --flavor {{flavor}} -t lib/main_{{flavor}}.dart --dart-define-from-file=.env/{{flavor}}.json -d {{device}}

# Build Android apk with {{flavor}}
build-apk flavor:
    fvm flutter build apk --flavor {{flavor}} -t lib/main_{{flavor}}.dart --obfuscate --split-debug-info=./android/split-debug/ --dart-define-from-file=.env/{{flavor}}.json

# Build Android appbundle with {{flavor}}
build-appbundle flavor:
    fvm flutter build appbundle --flavor {{flavor}} -t lib/main_{{flavor}}.dart --obfuscate --split-debug-info=./android/split-debug/ --dart-define-from-file=.env/{{flavor}}.json


# Generate all auto generate code
codegen:
    fvm flutter pub run build_runner build --delete-conflicting-outputs

# Clean project
clean:
    fvm flutter clean

# Get dependencies
get:
    fvm flutter pub get

# Run integration tests on {{device}}
integration-test device:
    fvm flutter test integration_test/app_test.dart --flavor prod --dart-define-from-file=.env/prod.json -d {{device}}

# Run unit tests
unit-test:
    fvm flutter test --dart-define-from-file=.env/prod.json

# Initial setup project
setup:
    just clean
    just get
    just codegen