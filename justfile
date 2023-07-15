# Show all commands
default:
    just --list

# Show all commands
help:
    just --list

# Run project with {{flavor}}, {{apikey}} and {{streamingApiKey}}
run flavor apiKey streamingApiKey device:
    fvm flutter run --flavor {{flavor}} -t lib/main_{{flavor}}.dart --dart-define API_KEY={{apiKey}} --dart-define STREAMING_API_KEY={{streamingApiKey}} -d {{device}}

# Build Android apk with {{flavor}}, {{apikey}} and {{streamingApiKey}}
build-apk flavor apiKey streamingApiKey:
    fvm flutter build apk --flavor {{flavor}} -t lib/main_{{flavor}}.dart --obfuscate --split-debug-info=./android/split-debug/ --dart-define API_KEY={{apiKey}} --dart-define STREAMING_API_KEY={{streamingApiKey}}

# Build Android appbundle with {{flavor}}, {{apikey}} and {{streamingApiKey}}
build-appbundle flavor apiKey streamingApiKey:
    fvm flutter build appbundle --flavor {{flavor}} -t lib/main_{{flavor}}.dart --obfuscate --split-debug-info=./android/split-debug/ --dart-define API_KEY={{apiKey}} --dart-define STREAMING_API_KEY={{streamingApiKey}}


# Generate all auto generate code
codegen:
    fvm flutter pub run build_runner build --delete-conflicting-outputs

# Clean project
clean:
    fvm flutter clean

# Get dependencies
get:
    fvm flutter pub get

# Run integration tests on {{device}} with {{apikey}} and {{streamingApiKey}}
integration-test apiKey streamingApiKey device:
    fvm flutter test integration_test/app_test.dart --flavor prod --dart-define API_KEY={{apiKey}} --dart-define STREAMING_API_KEY={{streamingApiKey}} -d {{device}}

# Run unit tests with {{apikey}} and {{streamingApiKey}}
unit-test apiKey streamingApiKey:
    fvm flutter test --dart-define API_KEY={{apiKey}} --dart-define STREAMING_API_KEY={{streamingApiKey}}

# Initial setup project
setup:
    just clean
    just get
    just codegen