import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/secure_keys.dart';
import 'package:tv_randshow/src/ui/views/app_view.dart';
import 'package:tv_randshow/src/ui/views/tvshow_search_view.dart';

void main() {
  /// Populate a string [apiKey] in [secure_keys.dart], or put below your personal API Key from TMDB
  FlavorConfig(
      flavor: Flavor.PROD, values: FlavorValues(baseUrl: 'api.themoviedb.org', apiKey: apiKey));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AppView(),
      routes: <String, WidgetBuilder>{'/search': (context) => SearchView()},
      localizationsDelegates: [
        FlutterI18nDelegate(useCountryCode: false, fallbackFile: 'en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
