// ignore_for_file: prefer-match-file-name
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/common/interfaces/i_local_preferences_service.dart';
import 'package:tv_randshow/common/services/local_preferences_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
void setupLocator() => locator.init(environment: kIsWeb ? 'web' : 'mobile');

@module
abstract class RegisterModule {
  @Singleton(as: ILocalPreferencesService)
  LocalPreferencesService get getLocalPreferences => LocalPreferencesService();

  @singleton
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();
}
