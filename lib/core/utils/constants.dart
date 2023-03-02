import 'package:flutter/material.dart';

class RoutePaths {
  static const String migraiton = 'migration';
  static const String tab = '/tab';
  static const String privacy = 'privacy';
  static const String splash = '/';
  static const String loading = 'loading';
  static const String result = 'result';
}

const String baseImage = 'https://image.tmdb.org/t/p/w342/';

class Assets {
  static const String emptyImage = 'assets/img/no_image.webp';
  static const String loading = 'assets/img/loading.flr';
  static const String placeHolder =
      'https://via.placeholder.com/288x256?text=no+image';
  static const String whatsNewEn = 'assets/markdown/whats_news_en.md';
  static const String whatsNewEs = 'assets/markdown/whats_news_es.md';
  static const String whatsNewPt = 'assets/markdown/whats_news_pt.md';
  static const String privacyPolicy = 'assets/markdown/privacy_policy.md';
}

class CustomTheme {
  static const Color _primary = Color(0xFFE40505);
  static const Color _darkGrey = Color(0xFF121212);

  final List<ThemeData> availableThemes = <ThemeData>[
    // Light theme
    ThemeData(
      fontFamily: 'Nunito',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _primary),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: EdgeInsets.zero,
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
        seedColor: _primary,
        brightness: Brightness.dark,
        background: _darkGrey,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: EdgeInsets.zero,
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
