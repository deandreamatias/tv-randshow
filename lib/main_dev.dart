import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'config/provider_setup.dart';
import 'core/utils/constants.dart';
import 'ui/router.dart';

void main() {
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'TV Randshow',
        theme: ThemeData(
          fontFamily: 'Nunito',
          primarySwatch: Colors.red,
        ),
        initialRoute: RoutePaths.SPLASH,
        onGenerateRoute: Router.generateRoute,
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          FlutterI18nDelegate(
            useCountryCode: false,
            fallbackFile: 'en',
            path: 'assets/i18n',
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('es'),
          Locale('pt'),
        ],
      ),
    );
  }
}
