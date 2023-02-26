import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:theme_provider/theme_provider.dart';

import '../core/utils/constants.dart';
import '../ui/router.dart' as router;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;

    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: "light_theme",
          description: "Light Theme",
          data: CustomTheme().availableThemes[0],
        ),
        AppTheme(
          id: "dark_theme",
          description: "Dark Theme",
          data: CustomTheme().availableThemes[1],
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => _MaterialApp(
            localizationDelegate: localizationDelegate,
            themeContext: themeContext,
          ),
        ),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  final BuildContext themeContext;
  final LocalizationDelegate localizationDelegate;

  const _MaterialApp({
    Key? key,
    required this.themeContext,
    required this.localizationDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: kIsWeb
          ? 'TV Randshow | App to choose a random TV show episode'
          : 'TV Randshow',
      theme: ThemeProvider.themeOf(themeContext).data,
      initialRoute: RoutePaths.SPLASH,
      onGenerateRoute: router.Router.generateRoute,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate,
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
    );
  }
}
