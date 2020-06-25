import 'dart:async';

import 'package:flutter/material.dart';

class ThemeManager {
  int _currentTheme = 0;
  final StreamController<ThemeData> _themeController =
      StreamController<ThemeData>();
  static const Color _PRIMARY = Color(0xFFE40505);
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
    ThemeData(
      // accentColor: PRIMARY,
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme(
        primary: _PRIMARY,
        primaryVariant: Colors.black,
        secondary: Colors.white,
        secondaryVariant: _PRIMARY,
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
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        contentPadding: EdgeInsets.all(0.0),
      ),
      primaryColor: _PRIMARY,
      accentColor: Colors.white,
      primarySwatch: const MaterialColor(0xFFE40505, _PRIMARY_SWATCH),
      dialogBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
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
  ];

  Stream<ThemeData> get theme => _themeController.stream;
  bool get isDarkTheme => _currentTheme != 0;

  Future<void> changeTheme() async {
    _currentTheme++;
    if (_currentTheme >= availableThemes.length) {
      _currentTheme = 0;
    }
    print('Currente theme: $_currentTheme');

    final ThemeData themeToApply = availableThemes[_currentTheme];

    _themeController.add(themeToApply);
  }
}
