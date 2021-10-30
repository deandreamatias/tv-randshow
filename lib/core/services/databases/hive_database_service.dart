import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/flavor_config.dart';
import '../../models/tvshow_details.dart';
import 'i_database_service.dart';

@Environment("web")
@LazySingleton(as: IDatabaseService)
class HiveDatabaseService extends IDatabaseService {
  Box<TvshowDetails>? tvshowBox;
  final tvshowBoxName =
      FlavorConfig.isDevelopment() ? 'tvshowfavdev' : 'tvshowfav';

  Future<void> init() async {
    if (kIsWeb) {
      Hive..registerAdapter(TvshowDetailsAdapter());
    } else {
      Directory? documentsDirectory;
      try {
        documentsDirectory = await getExternalStorageDirectory();
      } catch (e) {
        log('Can\'t open directory', error: e);
      }
      Hive
        ..init(documentsDirectory?.path ?? '')
        ..registerAdapter(TvshowDetailsAdapter());
    }
  }

  Future<void> loadBoxes() async {
    if (!await Hive.isBoxOpen(tvshowBoxName)) {
      await Hive.openBox<TvshowDetails>(tvshowBoxName);
    }
    tvshowBox = Hive.box<TvshowDetails>(tvshowBoxName);
  }

  @override
  Future<bool> deleteTvshow(int id) async {
    if (tvshowBox == null) {
      await init();
    }
    await loadBoxes();
    try {
      tvshowBox!.delete(id);
      log('Tvshow deleted: $id');
      return true;
    } catch (e) {
      log('Error to delete tvshow: $id', error: e);
      return false;
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    if (tvshowBox == null) {
      await init();
    }
    await loadBoxes();
    try {
      return (await tvshowBox!.values).toList();
    } catch (e) {
      log('Error to get tv shows', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    if (tvshowBox == null) {
      await init();
    }
    await loadBoxes();
    if (!tvshowBox!.containsKey(tvshowDetails.id)) {
      try {
        await tvshowBox!.put(tvshowDetails.id, tvshowDetails);
        log('Tvshow saved: ${tvshowDetails.id}');
        return true;
      } catch (e) {
        log('Error to save tvshow: ${tvshowDetails.id}', error: e);
        return false;
      }
    }
    return false;
  }
}
