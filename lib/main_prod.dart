import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'config/provider_setup.dart';
import 'core/utils/constants.dart';
import 'ui/router.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.PROD, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );

  runApp(LocalizedApp(delegate, MainApp()));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;

    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kIsWeb ? 'TV Randshow | App to choose a random TV show episode' : 'TV Randshow',
        theme: ThemeData(
          fontFamily: 'Nunito',
          primarySwatch: Colors.red,
        ),
        initialRoute: RoutePaths.TAB,
        onGenerateRoute: Router.generateRoute,
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
