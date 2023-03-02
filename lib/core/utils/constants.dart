import 'package:flutter/material.dart';

class RoutePaths {
  static const String MIGRATION = 'migration';
  static const String TAB = '/tab';
  static const String PRIVACY = 'privacy';
  static const String SPLASH = '/';
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
  static const String PRIVACY_POLICY = 'assets/markdown/privacy_policy.md';
}

class CustomTheme {
  static const Color _PRIMARY = Color(0xFFE40505);
  static const Color _DARK_GREY = Color(0xFF121212);

  final List<ThemeData> availableThemes = <ThemeData>[
    // Light theme
    ThemeData(
      fontFamily: 'Nunito',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _PRIMARY),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    ),
    // Dark theme
    ThemeData(
      fontFamily: 'Nunito',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _PRIMARY,
        brightness: Brightness.dark,
        background: _DARK_GREY,
      ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    ),
  ];
}
