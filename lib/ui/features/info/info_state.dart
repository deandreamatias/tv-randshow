import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/common/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';

final versionAppProvider = FutureProvider.autoDispose<String>((ref) {
  final IAppService appService = locator<IAppService>();

  return appService.getVersion();
});
