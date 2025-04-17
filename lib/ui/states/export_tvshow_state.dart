import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/io/domain/use_cases/export_tvshows_use_case.dart';
import 'package:tv_randshow/ui/shared/async_value_extension.dart';

class ExportTvShowsNotifier extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return true;
  }

  void export() async {
    state = const AsyncValue.loading();
    state = await AsyncValueExtension.catchGuard<bool>(
      () => locator<ExportTvShowsUseCase>()(),
    );
  }
}

final exportTvshowsProvider =
    AsyncNotifierProvider.autoDispose<ExportTvShowsNotifier, bool>(
      ExportTvShowsNotifier.new,
    );
