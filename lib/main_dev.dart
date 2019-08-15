import 'package:flutter/material.dart';

import 'package:tv_randshow/config/secure_keys.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/generated/i18n.dart';
import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/models/tv_search/tvshow_search.dart';
import 'package:tv_randshow/src/resources/api_provider.dart';
import 'package:tv_randshow/src/resources/secure_storage.dart';
import 'package:tv_randshow/src/utils/constants.dart';

void main() {
  final AppModel appModel = AppModel();

  /// Populate a string [apiKey] in [secure_keys.dart], or put below your personal API Key from TMDB
  FlavorConfig(
      flavor: Flavor.DEV, values: FlavorValues(baseUrl: 'api.themoviedb.org', apiKey: apiKey));
  appModel.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      localizationsDelegates: [I18n.delegate],
      supportedLocales: I18n.delegate.supportedLocales,
      localeResolutionCallback: I18n.delegate.resolution(fallback: Locale('en', 'US')),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SecureStorage secureStorage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).name_app),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _request();
              },
              child: Text('Test api'),
            ),
          ],
        ),
      ),
    );
  }

  _request() async {
    TvshowSearch tvshowSearch;
    final apiKey = await secureStorage.readStorage(KeyStorate.API_KEY);
    var queryParameters = {'api_key': apiKey, 'language': 'en-US', 'page': '1', 'query': 'friends'};
    var uri = Uri.https(Url.apiUrl, Url.TVSHOW_SEARCH, queryParameters);
    print(uri.toString());
    ApiProvider().requestGet(uri.toString()).then((response) {
      print('Reponse: ${response.statusCode}');
      tvshowSearch = TvshowSearch.fromRawJson(response.body);
      tvshowSearch.results.forEach((f) {
        print('Name of results: ${f.name}');
      });
    });
  }
}
