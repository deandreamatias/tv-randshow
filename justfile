default:
    just --list

help:
    just --list

codegen-build:
    fvm flutter pub run build_runner build --delete-conflicting-outputs

clean:
    fvm flutter clean
 
get:
    fvm flutter pub get 

setup:
    just clean
    just get
    just codegen-build