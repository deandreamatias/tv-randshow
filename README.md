<p>
  <a href="https://tvrandshow.com/">
    <img alt="TV Randshow website" src="./images/icon.png" height="100">
  </a>
  <a href='https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
    <img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' height="100" />
  </a>
</p>

## TV Randshow - App to choose a random TV show episode

[![Build and test](https://github.com/deandreamatias/tv-randshow/actions/workflows/build.yaml/badge.svg)](https://github.com/deandreamatias/tv-randshow/actions/workflows/build.yaml)
[![Releases](https://img.shields.io/github/v/release/deandreamatias/tv-randshow)](https://github.com/deandreamatias/tv-randshow/releases)
[![Google Play](https://img.shields.io/badge/google--play-Google--Play-green?label=App)](https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow)
[![IzzyOnDroid](https://img.shields.io/endpoint?url=https://apt.izzysoft.de/fdroid/api/v1/shield/deandrea.matias.tv_randshow/)](https://apt.izzysoft.de/fdroid/index/apk/deandrea.matias.tv_randshow/)
[![Website](https://img.shields.io/website?up_message=online&url=https%3A%2F%2Ftvrandshow.com%2F)](https://tvrandshow.com/)
[![Paypal donate](https://img.shields.io/badge/paypal-donate-blue)](https://www.paypal.com/donate/?hosted_button_id=QWL5BXSRLCUJJ)

### About the project

TV Randshow was created to help choose a random episode from your favorites TV shows.
The TV shows database comes from the TMDB and the app saves them in a database on the device. With the list of favorites, you can roll the dice of a TV show to get a random episode.

This project has been built using the [Flutter](https://flutter.dev/) framework, which allows to build an multiplatform app from a single codebase.

<p align="center">
  <img src="./images/search.png" width="150" hspace="4">
  <img src="./images/favs.png" width="150" hspace="4">
  <img src="./images/result.png" width="150" hspace="4">
  <img src="./images/info.png" width="150" hspace="4">
</p>

## Features

- **Save your favorites TV shows with available streamings links**
- **Choose a random episode from a single TV show**
- **Choose a random episode from all saved TV shows**
- **Choose a random TV show from trending TMDB**
- **Support to Android and Web**
- **Export saved TV shows to json**
- **Dark mode**
- **Material Design 3**

## Build and run

### Requirements

1. Clone repository with 'git clone' command or just download the zip. `git clone git@github.com:deandreamatias/tv-randshow.git`
2. Prepare your develop enviroment
   1. Flutter (see version in `.fvmrc`). Use [FVM 3.0](https://fvm.app/docs/getting_started/installation) to install Flutter versions
   2. When build to iOS, follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-xcode)
   3. When build to Android, follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-android-studio)
3. Install dependencies and generate code
   1. Only use `sh tool/setup.sh`
   2. If don't have just, can do manual proccess
      1. Run `flutter pub get` from the project root (see [using packages documentation](https://flutter.dev/docs/development/packages-and-plugins/using-packages#adding-a-package-dependency-to-an-app) for details and how to do this in the editor).
      2. Run `flutter pub run build_runner build`
4. Get your own API keys
   1. Get your API Key from TMDB (see [this FAQ](https://www.themoviedb.org/faq/api) for more details).
   2. Get your API Key from Streaming Availabilty (on [RapidApi](https://rapidapi.com/movie-of-the-night-movie-of-the-night-default/api/streaming-availability))
   3. Paste your API keys values in `.env/dev.json` or `.env/prod.json` files. Take `.env/dev.example.json` like example.
5. (Optional) If you want build to web, do you need follow [this steps](https://flutter.dev/docs/get-started/web)

### Run

Run `sh tool/run.sh dev` command or copy the command from `tool/run.sh`.

### Tests

- Integration tests (only mobile): run `sh tool/integration-test.sh` command or copy the command from `tool/integration-test.sh`.
- Unit tests: run `sh tool/unit-test.sh unit` command or copy the command from `tool/unit-test.sh`.

### Build

- Android APK: Run `sh tool/build-android.sh apk` command or copy the command from `tool/build-android.sh`.

## Author

- **Matias de Andrea** - Mobile developer: [Website](https://deandreamatias.com)

## Contributing

If you want to take the time to make this project better, please read the [contributing guides](https://github.com/deandreamatias/tv-randshow/blob/master/CONTRIBUTING.md) first. Then, you can open an new [issue](https://github.com/deandreamatias/tv-randshow/issues/new/choose), of a [pull request](https://github.com/deandreamatias/tv-randshow/compare).

## Powered by

<img src="https://www.themoviedb.org/assets/2/v4/logos/v2/blue_long_2-9665a76b1ae401a510ec1e0ca40ddcb3b0cfe45f1d51b77a308fea0845885648.svg" width="200">

TV information and images are provided by TMDb, but we are not endorsed or certified by TMDb.com or its affiliates.
