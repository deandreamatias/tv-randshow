# Show all commands
default:
    just --list

# Show all commands
help:
    just --list

# Run project with {{flavor}}
run flavor device:
    fvm flutter run --flavor {{flavor}} -t lib/main_{{flavor}}.dart -d {{device}}

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