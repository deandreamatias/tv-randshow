<p align="center">
  <img src="https://raw.githubusercontent.com/deandreamatias/tv-randshow/master/assets/img/icon_launcher.png" width="100">
</p>
<h1 align="center">TV Randshow</h1>
<h3 align="center">App to choose a random TV show episode</h3>

<p align="center">
  <a>
    <img src="https://img.shields.io/github/v/release/deandreamatias/tv-randshow">
  </a>
</p>

### About the project

TV Randshow was created to help choose a random episode from a user's favorite TV shows.
The TV shows database comes from the TMDB and the app partially saves them in a database on the device. With the list of favorites, you can roll the dice of a TV shows to get a random episode.

This project has been built using the [Flutter](https://flutter.dev/) framework, which allows to build an app for mobile, desktop & web, from a single codebase.

<p align="center">
  <img src="https://github.com/deandreamatias/tv-randshow/blob/master/screenshots/search.jpg" width="180" hspace="4">
  <img src="https://github.com/deandreamatias/tv-randshow/blob/master/screenshots/favs.jpg" width="180" hspace="4">
  <img src="https://github.com/deandreamatias/tv-randshow/blob/master/screenshots/details.jpg" width="180" hspace="4">
  <img src="https://github.com/deandreamatias/tv-randshow/blob/master/screenshots/result.jpg" width="180" hspace="4">
</p>

## Features

- **Save your favorites TV shows**
- **Choose a random episode from a single TV show**
- Coming soon...

## Tools

- [**Scoped model**](https://pub.dev/packages/scoped_model)
- [**SQFlite**](https://pub.dev/packages/sqflite)
- [**TMDB API**](https://developers.themoviedb.org/3/getting-started/introduction)
- [**Flare animation loading**](https://rive.app/a/deandreamatias/files/flare/loading-tv-randshow/embed)
- [**Logger**](https://pub.dev/packages/logger)

## Download & install

First, clone the repository with the 'clone' command, or just download the zip.

```
$ git clone git@github.com:deandreamatias/tv-randshow.git
```

Then, download either Android Studio or Visual Studio Code, with their respective [Flutter editor plugins](https://flutter.dev/docs/get-started/editor). For more information about Flutter installation procedure, check the [official install guide](https://flutter.dev/docs/get-started/install).

Install dependencies from pubspec.yaml by running `flutter packages get` from the project root (see [using packages documentation](https://flutter.dev/docs/development/packages-and-plugins/using-packages#adding-a-package-dependency-to-an-app) for details and how to do this in the editor).

Get your API Key from TMDB (see [this FAQ](https://www.themoviedb.org/faq/api) for more details).

Run with CLI:
`flutter run --flavor dev -t lib/main_dev.dart `

## Built with

- [Flutter](https://flutter.dev/) - Beautiful native apps in record time.
- [Android Studio](https://developer.android.com/studio/index.html/) - Tools for building apps on every type of Android device.
- [Visual Studio Code](https://code.visualstudio.com/) - Code editing. Redefined.

## Author

- **Matias de Andrea** - Mobile developer and UI/UX designer: [GitHub](https://github.com/deandreamatias), [Twitter](https://twitter.com/deandreamatias) & [Behance](https://www.behance.net/deandreamatias).

## Contributing

If you want to take the time to make this project better, please read the [contributing guides](https://github.com/jesusrp98/spacex-go/blob/master/CONTRIBUTING.md) first. Then, you can open an new [issue](https://github.com/deandreamatias/tv-randshow/issues/new/choose), of a [pull request](https://github.com/deandreamatias/tv-randshow/compare).

## License

This project is licensed under the GNU GPL v3 License - see the [LICENSE](LICENSE) file for details.
