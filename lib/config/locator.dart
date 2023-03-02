import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/interfaces/local_preferences_service.dart';
import 'package:tv_randshow/common/services/shared_preferences_service.dart';

import 'package:tv_randshow/config/locator.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
void setupLocator() => locator.init(environment: kIsWeb ? 'web' : 'mobile');

@module
abstract class RegisterModule {
  @LazySingleton(as: ILocalPreferencesService)
  SharedPreferencesService get getLocalPreferences =>
      SharedPreferencesService();

  @singleton
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();
}
