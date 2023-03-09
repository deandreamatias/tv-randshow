import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';

import 'package:tv_randshow/ui/router.dart' as router;
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/styles.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;

    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: 'light_theme',
          description: 'Light Theme',
          data: CustomTheme().availableThemes[0],
        ),
        AppTheme(
          id: 'dark_theme',
          description: 'Dark Theme',
          data: CustomTheme().availableThemes[1],
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => ProviderScope(
            child: _MaterialApp(
              localizationDelegate: localizationDelegate,
              themeContext: themeContext,
            ),
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
    required this.themeContext,
    required this.localizationDelegate,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kIsWeb
          ? 'TV Randshow | App to choose a random TV show episode'
          : 'TV Randshow',
      theme: ThemeProvider.themeOf(themeContext).data,
      initialRoute: RoutePaths.splash,
      scaffoldMessengerKey: locator.get<GlobalKey<ScaffoldMessengerState>>(),
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
