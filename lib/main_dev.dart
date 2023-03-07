import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:tv_randshow/core/app/domain/models/env.dart';
import 'package:tv_randshow/core/app/domain/models/flavor_config.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/app.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues.fromJson(environment));
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: <String>['en', 'es', 'pt'],
  );
  setupLocator();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  runApp(LocalizedApp(delegate, const App()));
}
