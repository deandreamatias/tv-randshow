import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/secure_keys.dart';
import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/ui/screens/tvshow_fav_view.dart';
import 'package:tv_randshow/src/ui/screens/tvshow_search_view.dart';

void main() {
  final AppModel appModel = AppModel();
  FlavorConfig(

      /// Populate a string [apiKey] in [secure_keys.dart], or put below your personal API Key from TMDB
      flavor: Flavor.PROD,
      values: FlavorValues(baseUrl: 'api.themoviedb.org', apiKey: apiKey));
  appModel.init();
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
      home: TvshowFavView(),
      routes: <String, WidgetBuilder>{'/search': (context) => TvshowSearchView()},
      localizationsDelegates: [
        FlutterI18nDelegate(useCountryCode: false, fallbackFile: 'en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
