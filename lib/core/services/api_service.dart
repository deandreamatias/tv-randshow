import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/core/models/query.dart';
import 'package:tv_randshow/core/models/search.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/models/tvshow_seasons_details.dart';
import 'package:tv_randshow/core/utils/constants.dart';

@lazySingleton
class ApiService {
  static BaseOptions options = BaseOptions(
    baseUrl: FlavorConfig.instance.values.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  // Documentation: https://developers.themoviedb.org/3/search/search-tv-shows
  Future<Search> getSearch(Query query) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        tvshowSearch,
        queryParameters: query.toJson(),
      );
      return Search.fromJson(response.data);
    } on DioError catch (e) {
      log('Error to fetch search: ${e.message}', error: e);
      return Search();
    }
  }

// Documentation: https://developers.themoviedb.org/3/tv/get-tv-details
  Future<TvshowDetails> getDetailsTv(Query query, int idTv) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        '$tvshowDetails$idTv',
        queryParameters: query.toJson(),
      );
      return TvshowDetails.fromJson(response.data);
    } on DioError catch (e) {
      log('Error to fetch Tv show details: ${e.message}', error: e);
      throw ErrorDescription(e.toString());
    }
  }

// Documentation: https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
  Future<TvshowSeasonsDetails> getDetailsTvSeasons(
    Query query,
    int idTv,
    int idSeason,
  ) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        '$tvshowDetails$idTv$tvshowDetailsSeason$idSeason',
        queryParameters: query.toJson(),
      );
      return TvshowSeasonsDetails.fromJson(response.data);
    } on DioError catch (e) {
      log('Error to fetch Tvshow seasons details: ${e.message}', error: e);
      throw ErrorDescription(e.toString());
    }
  }
}
