import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:theme_provider/theme_provider.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'config/locator.dart';
import 'core/utils/constants.dart';
import 'ui/router.dart' as router;

Future<void> main() async {
  FlavorConfig(flavor: Flavor.PROD, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );
  setupLocator();

  runApp(LocalizedApp(delegate, MainApp()));
}

class MainApp extends StatelessWidget {
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
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: kIsWeb
                ? 'TV Randshow | App to choose a random TV show episode'
                : 'TV Randshow',
            theme: ThemeProvider.themeOf(themeContext).data,
            initialRoute: RoutePaths.TAB,
            onGenerateRoute: router.Router.generateRoute,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate,
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
          ),
        ),
      ),
    );
  }
}
