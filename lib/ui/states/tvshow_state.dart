import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/add_fav_tvshow_use_case.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/delete_fav_tvshow_use_case.dart';
import 'package:tv_randshow/ui/shared/async_value_extension.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';

class TvshowNotifier extends AutoDisposeFamilyAsyncNotifier<bool, int> {
  final AddFavTvshowUseCase _addFavTvshow = locator<AddFavTvshowUseCase>();
  final DeleteFavTvshowUseCase _deleteFavTvshow =
      locator<DeleteFavTvshowUseCase>();
  @override
  FutureOr<bool> build(int arg) {
    return ref.read(favTvshowsProvider.notifier).hasFav(arg);
  }

  Future<void> addToFavs() async {
    if (state.hasValue && !state.requireValue) {
      state = const AsyncValue.loading();
      state = await AsyncValueExtension.catchGuard<bool>(() async {
        final tvshowDetails = await _addFavTvshow(idTv: arg);
        ref.read(favTvshowsProvider.notifier).addFav(tvshowDetails);

        return true;
      });
    }
  }

  Future<void> deleteFromFavs() async {
    if (state.hasValue && state.requireValue) {
      state = const AsyncValue.loading();
      state = await AsyncValueExtension.catchGuard<bool>(() async {
        await _deleteFavTvshow(arg);
        ref.read(favTvshowsProvider.notifier).deleteFav(arg);

        return false;
      });
    }
  }
}

final tvshowOnFavsProvider =
    AutoDisposeAsyncNotifierProviderFamily<TvshowNotifier, bool, int>(
      TvshowNotifier.new,
    );
