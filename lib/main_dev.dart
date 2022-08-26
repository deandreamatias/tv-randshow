import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'config/env.dart';
import 'config/flavor_config.dart';
import 'config/locator.dart';
import 'ui/app.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );
  setupLocator();

  runApp(LocalizedApp(delegate, App()));
}
