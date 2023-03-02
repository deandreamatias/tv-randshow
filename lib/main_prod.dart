import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/ui/app.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.prod, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );
  setupLocator();

  runApp(LocalizedApp(delegate, const App()));
}
