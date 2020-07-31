import 'package:flutter/material.dart';

class RoutePaths {
  static const String TAB = '/';
  static const String SPLASH = 'splash';
  static const String LOADING = 'loading';
  static const String RESULT = 'result';
}

const String BASE_IMAGE = 'https://image.tmdb.org/t/p/w342/';
const String API_VERSION = '/3';
const String TVSHOW_SEARCH = '$API_VERSION/search/tv';
const String TVSHOW_DETAILS = '$API_VERSION/tv/';
const String TVSHOW_DETAILS_SEASON = '/season/';

class Assets {
  static const String EMPTY_IMAGE = 'assets/img/no_image.webp';
  static const String LOADING = 'assets/img/loading.flr';
  static const String PLACE_HOLDER =
      'https://via.placeholder.com/288x256?text=no+image';
  static const String WHATS_NEW_EN = 'assets/markdown/whats_news_en.md';
  static const String WHATS_NEW_ES = 'assets/markdown/whats_news_es.md';
  static const String WHATS_NEW_PT = 'assets/markdown/whats_news_pt.md';
}

class CustomTheme {
  static const Color _PRIMARY = Color(0xFFE40505);
  static const Color _DARK_GREY = Color(0xFF121212);
  static const Map<int, Color> _PRIMARY_SWATCH = <int, Color>{
    50: Color.fromRGBO(228, 5, 5, .1),
    100: Color.fromRGBO(228, 5, 5, .2),
    200: Color.fromRGBO(228, 5, 5, .3),
    300: Color.fromRGBO(228, 5, 5, .4),
    400: Color.fromRGBO(228, 5, 5, .5),
    500: Color.fromRGBO(228, 5, 5, .6),
    600: Color.fromRGBO(228, 5, 5, .7),
    700: Color.fromRGBO(228, 5, 5, .8),
    800: Color.fromRGBO(228, 5, 5, .9),
    900: Color.fromRGBO(228, 5, 5, 1),
  };

  final List<ThemeData> availableThemes = <ThemeData>[
    // Light theme
    ThemeData(
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme(
        primary: _PRIMARY,
        primaryVariant: _PRIMARY,
        secondary: Colors.white,
        secondaryVariant: Colors.black,
        surface: Colors.white,
        background: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.black,
        brightness: Brightness.light,
      ),
      primaryColor: _PRIMARY,
      accentColor: _PRIMARY,
      dialogBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      primarySwatch: const MaterialColor(0xFFE40505, _PRIMARY_SWATCH),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: EdgeInsets.all(0.0),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        modalBackgroundColor: Colors.transparent,
        modalElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(16.0),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: _PRIMARY),
        ),
        buttonColor: _PRIMARY,
        textTheme: ButtonTextTheme.primary,
      ),
    ),
    // Dark theme
    ThemeData(
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme(
        primary: _PRIMARY,
        primaryVariant: _PRIMARY,
        secondary: Colors.white,
        secondaryVariant: Colors.black,
        surface: _DARK_GREY,
        background: _DARK_GREY,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      primaryColor: _PRIMARY,
      accentColor: Colors.white,
      dialogBackgroundColor: _DARK_GREY,
      backgroundColor: _DARK_GREY,
      primarySwatch: const MaterialColor(0xFFE40505, _PRIMARY_SWATCH),
      toggleableActiveColor: _PRIMARY,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: EdgeInsets.all(0.0),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: _DARK_GREY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        modalBackgroundColor: Colors.transparent,
        modalElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(16.0),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        buttonColor: _PRIMARY,
        textTheme: ButtonTextTheme.primary,
      ),
    ),
  ];
}
