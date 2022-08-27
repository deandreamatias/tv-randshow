import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:theme_provider/theme_provider.dart';

import '../config/locator.dart';
import '../core/tvshow/domain/use_cases/verify_old_database_use_case.dart';
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
          builder: (themeContext) => kIsWeb
              ? _MaterialApp(
                  localizationDelegate: localizationDelegate,
                  themeContext: themeContext,
                )
              : FutureBuilder<bool>(
                  future: locator<VerifyOldDatabaseUseCase>()(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Container(
                        child: CircularProgressIndicator(),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                      );
                    return _MaterialApp(
                      localizationDelegate: localizationDelegate,
                      themeContext: themeContext,
                      showMigrationView: snapshot.data!,
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  final bool showMigrationView;
  final BuildContext themeContext;
  const _MaterialApp({
    Key? key,
    this.showMigrationView = false,
    required this.themeContext,
    required this.localizationDelegate,
  }) : super(key: key);

  final LocalizationDelegate localizationDelegate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: kIsWeb
          ? 'TV Randshow | App to choose a random TV show episode'
          : 'TV Randshow',
      theme: ThemeProvider.themeOf(themeContext).data,
      initialRoute: showMigrationView ? RoutePaths.MIGRATION : RoutePaths.TAB,
      onGenerateRoute: router.Router.generateRoute,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate,
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
    );
  }
}
