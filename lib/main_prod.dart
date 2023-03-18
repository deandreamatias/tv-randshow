import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/common/models/env.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/app.dart';
import 'package:tv_randshow/ui/shared/show_snackbar.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.prod, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );
  setupLocator();

  PlatformDispatcher.instance.onError = (error, stack) {
    showSnackBar('Something went wrong', details: error.toString());
    debugPrintStack(label: error.toString(), stackTrace: stack);

    return true;
  };

  runApp(LocalizedApp(delegate, const App()));
}
