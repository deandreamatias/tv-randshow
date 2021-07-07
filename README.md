<p>
  <a href="https://tvrandshow.com/">
    <img alt="TV Randshow website" src="./images/icon.png" height="100">
  </a>
  <a href='https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
    <img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' height="100" />
  </a>
</p>

## TV Randshow - App to choose a random TV show episode

![Unit tests](https://github.com/deandreamatias/tv-randshow/workflows/Unit%20tests/badge.svg)
![Integration test](https://github.com/deandreamatias/tv-randshow/workflows/Integration%20test/badge.svg)
[![Releases](https://img.shields.io/github/v/release/deandreamatias/tv-randshow)](https://github.com/deandreamatias/tv-randshow/releases)
[![Google Play](https://img.shields.io/badge/google--play-Google--Play-green?label=App)](https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow)
[![Website](https://img.shields.io/website?up_message=online&url=https%3A%2F%2Ftvrandshow.com%2F)](https://tvrandshow.com/)
[![Paypal donate](https://img.shields.io/badge/paypal-donate-blue)](https://paypal.me/deandreamatias)

### About the project

TV Randshow was created to help choose a random episode from your favorites TV shows.
The TV shows database comes from the TMDB and the app saves them in a database on the device. With the list of favorites, you can roll the dice of a TV show to get a random episode.

This project has been built using the [Flutter](https://flutter.dev/) framework, which allows to build an app for mobile, desktop & web, from a single codebase.

<p align="center">
  <img src="./images/search.png" width="150" hspace="4">
  <img src="./images/favs.png" width="150" hspace="4">
  <img src="./images/result.png" width="150" hspace="4">
  <img src="./images/details.png" width="150" hspace="4">
  <img src="./images/info.png" width="150" hspace="4">
</p>

## Features

- **Save your favorites TV shows**
- **Choose a random episode from a single TV show**
- **Support to Android and Web**
- **Dark mode**
- **Support to deeplink `https://tvrandshow.com/getRandomEpisode?tvshow=friends`**
- [Coming soon...](https://trello.com/b/ib0jdUzK)

## Build & run

### Requirements

- First, clone the repository with the 'git clone' command, or just download the zip.

```git
git clone git@github.com:deandreamatias/tv-randshow.git
```

- Then, download either Android Studio or Visual Studio Code, with their respective [Flutter editor plugins](https://flutter.dev/docs/get-started/editor). For more information about Flutter installation procedure, check the [official install guide](https://flutter.dev/docs/get-started/install).

- Install dependencies from pubspec.yaml by running `flutter packages get` from the project root (see [using packages documentation](https://flutter.dev/docs/development/packages-and-plugins/using-packages#adding-a-package-dependency-to-an-app) for details and how to do this in the editor).

- Get your API Key from TMDB (see [this FAQ](https://www.themoviedb.org/faq/api) for more details) and paste in file `lib/config/env.dart`

- (Optional) If you want build to web, do you need follow [this steps](https://flutter.dev/docs/get-started/web)

### Run

CLI Debug: `flutter run --flavor dev -t lib/main_dev.dart`

### Tests

Integration tests (only mobile): `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d [DEVICE_ID] --flavor dev`
Unit tests: `flutter test --flavor dev`

## Author

- **Matias de Andrea** - Mobile developer: [Website](https://deandreamatias.com), [GitHub](https://github.com/deandreamatias) & [Twitter](https://twitter.com/deandreamatias).

## Contributing

If you want to take the time to make this project better, please read the [contributing guides](https://github.com/deandreamatias/tv-randshow/blob/master/CONTRIBUTING.md) first. Then, you can open an new [issue](https://github.com/deandreamatias/tv-randshow/issues/new/choose), of a [pull request](https://github.com/deandreamatias/tv-randshow/compare).

## License

This project is licensed under the GNU GPL v3 License - see the [LICENSE](LICENSE) file for details.
