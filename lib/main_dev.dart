import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persist_theme/persist_theme.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'config/locator.dart';
import 'core/utils/constants.dart';
import 'ui/router.dart' as router;

Future<void> main() async {
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));
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

    return PersistTheme(
      model: ThemeModel(
        customLightTheme: CustomTheme().availableThemes[0],
        customDarkTheme: CustomTheme().availableThemes[1],
      ),
      builder: (BuildContext context, ThemeModel model, Widget child) =>
          MaterialApp(
        debugShowCheckedModeBanner: true,
        title: kIsWeb
            ? 'TV Randshow | App to choose a random TV show episode'
            : 'TV Randshow',
        theme: model.theme,
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
    );
  }
}
