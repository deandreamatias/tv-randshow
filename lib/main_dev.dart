import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/src/services/service_locator.dart';
import 'package:tv_randshow/src/ui/views/app_view.dart';
import 'package:tv_randshow/src/ui/views/loading_view.dart';
import 'config/env.dart';

void main() {
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));
  print(FlavorConfig.instance.values.baseUrl);
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
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
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
