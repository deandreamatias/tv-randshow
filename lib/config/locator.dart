import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:tv_randshow/config/locator.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
void setupLocator() => locator.init(environment: kIsWeb ? 'web' : 'mobile');
