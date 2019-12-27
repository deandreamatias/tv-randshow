import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'src/services/service_locator.dart';
import 'src/ui/views/app_view.dart';
import 'src/ui/views/loading_view.dart';

void main() {
  FlavorConfig(flavor: Flavor.PROD, values: FlavorValues.fromJson(environment));
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TV Randshow',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.red,
      ),
      home: const AppView(),
      routes: <String, WidgetBuilder>{
        '/loading': (BuildContext context) => const LoadingView()
      },
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        FlutterI18nDelegate(
            useCountryCode: false, fallbackFile: 'en', path: 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
