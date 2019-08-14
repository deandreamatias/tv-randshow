import 'package:flutter/material.dart';

import 'package:tv_randshow/config/secure_keys.dart';
import 'package:tv_randshow/generated/i18n.dart';

import 'config/flavor_config.dart';

void main() {
  /// Populate a string [apiKey] in [secure_keys.dart], or put below your personal API Key from TMDB 
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
          baseUrl:
              "https://raw.githubusercontent.com/JHBitencourt/ready_to_go/master/lib/json/person_qa.json", 
              apiKey: apiKey));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              onPressed: () => {},
              child: Text('Test api'),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
