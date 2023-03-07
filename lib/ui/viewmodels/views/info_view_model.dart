import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/domain/interfaces/i_app_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';

final versionAppProvider = FutureProvider.autoDispose<String>((ref) async {
  final IAppService appService = locator<IAppService>();
  return appService.getVersion();
});

class ExportTvShowsNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return true;
  }

  void export() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => locator<ExportTvShowsUseCase>()(),
    );
  }
}

final exportTvshowsProvider =
    AsyncNotifierProvider.autoDispose<ExportTvShowsNotifier, bool>(
  ExportTvShowsNotifier.new,
);
