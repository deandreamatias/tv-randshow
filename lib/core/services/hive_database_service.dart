import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tv_randshow/config/flavor_config.dart';

import '../models/tvshow_details.dart';

abstract class IDatabaseService {
  Future<bool> saveTvshow(TvshowDetails tvshowDetails);
  Future<List<TvshowDetails>> getTvshows();
  Future<bool> deleteTvshow(int rowId);
}

@lazySingleton
class HiveDatabaseService extends IDatabaseService {
  Box tvshowBox;
  Box preferencesBox;

  Future<void> init() async {
    Directory documentsDirectory;
    try {
      documentsDirectory = await getExternalStorageDirectory();
    } catch (e) {
      log('Can\'t open directory', error: e);
    }
    if (kIsWeb) {
      Hive..registerAdapter(TvshowDetailsAdapter());
    } else {
      Hive
        ..init(documentsDirectory.path)
        ..registerAdapter(TvshowDetailsAdapter());
    }

    tvshowBox = await Hive.openBox(
        FlavorConfig.isDevelopment() ? 'tvshowfavdev' : 'tvshowfav');
    preferencesBox =
        await Hive.openBox(FlavorConfig.isDevelopment() ? 'prefsdev' : 'prefs');
  }

  @override
  Future<bool> deleteTvshow(int rowId) async {
    try {
      tvshowBox.delete(rowId);
      log('Tvshow deleted: $rowId');
      return true;
    } catch (e) {
      log('Error to delete tvshow: $rowId');
      return false;
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    // TODO: Implement save tvshow list
    tvshowBox.get('dave');
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    try {
      await tvshowBox.put(tvshowDetails.rowId, tvshowDetails);
      log('Tvshow saved: ${tvshowDetails.rowId}');
      return true;
    } catch (e) {
      log('Error to save tvshow: ${tvshowDetails.rowId}');
      return false;
    }
  }
}
