import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/core/tvshow/domain/use_cases/get_local_tvshows_use_case.dart';

@lazySingleton
class FavsService {
  FavsService({
    required ILocalRepository databaseService,
  }) : _databaseService = databaseService;
  final ILocalRepository _databaseService;
  final GetLocalTvshowsUseCase _getLocalTvshows =
      locator<GetLocalTvshowsUseCase>();

  StreamController<List<TvshowDetails>> streamController =
      StreamController<List<TvshowDetails>>.broadcast();

  Stream<List<TvshowDetails>> get listFavs => streamController.stream;

  Future<void> getFavs() async {
    streamController.add(await _getLocalTvshows());
  }

  Future<void> deleteFav(int id) async {
    await _databaseService.deleteTvshow(id);
    streamController.add(await _getLocalTvshows());
  }
}
