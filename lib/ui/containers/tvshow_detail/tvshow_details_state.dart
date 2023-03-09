import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_tvshow_details_use_case.dart';

class TvshowDetailsNotifier
    extends AutoDisposeFamilyAsyncNotifier<TvshowDetails, int> {
  final GetTvshowDetailsUseCase _getTvshowDetailsUseCase =
      locator<GetTvshowDetailsUseCase>();

  @override
  FutureOr<TvshowDetails> build(int arg) {
    return _getTvshowDetailsUseCase(arg);
  }
}

final tvshowDetailsProvider = AutoDisposeAsyncNotifierProviderFamily<
    TvshowDetailsNotifier, TvshowDetails, int>(
  TvshowDetailsNotifier.new,
);
