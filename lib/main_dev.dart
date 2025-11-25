import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:tv_randshow/common/models/env.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/app.dart';
import 'package:tv_randshow/ui/shared/show_snackbar.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.dev, values: FlavorValues.fromJson(environment));
  setupLocator();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;

    return stack;
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    showSnackBar('Something went wrong', details: error.toString());
    debugPrintStack(label: error.toString(), stackTrace: stack);

    return true;
  };
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es'), Locale('pt')],
      path: 'assets/i18n',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('en'),
      child: const App(),
    ),
  );
}
