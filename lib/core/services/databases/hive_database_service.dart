import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';

import '../../../config/flavor_config.dart';
import '../../models/tvshow_details.dart';
import '../../streaming/data/models/streaming_detail_hive.dart';
import 'i_database_service.dart';

@Environment("web")
@LazySingleton(as: IDatabaseService)
class HiveDatabaseService extends IDatabaseService {
  Box<TvshowDetails>? tvshowBox;
  Box<StreamingDetailHive>? streamingsBox;
  final tvshowBoxName =
      FlavorConfig.isDevelopment() ? 'tvshowfavdev' : 'tvshowfav';
  final streamingsBoxName =
      FlavorConfig.isDevelopment() ? 'streamingsdev' : 'streamings';

  Future<void> _init() async {
    if (tvshowBox != null && streamingsBox != null) {
      return;
    }
    if (kIsWeb) {
      Hive
        ..registerAdapter(TvshowDetailsAdapter())
        ..registerAdapter(StreamingDetailHiveAdapter());
    } else {
      Directory? documentsDirectory;
      try {
        documentsDirectory = await getExternalStorageDirectory();
      } catch (e) {
        log('Can\'t open directory', error: e);
      }
      Hive
        ..init(documentsDirectory?.path ?? '')
        ..registerAdapter(TvshowDetailsAdapter())
        ..registerAdapter(StreamingDetailHiveAdapter());
    }
  }

  Future<void> _loadBoxes() async {
    if (!await Hive.isBoxOpen(tvshowBoxName)) {
      await Hive.openBox<TvshowDetails>(tvshowBoxName);
    }
    if (!await Hive.isBoxOpen(streamingsBoxName)) {
      await Hive.openBox<StreamingDetailHive>(streamingsBoxName);
    }
    tvshowBox ??= Hive.box<TvshowDetails>(tvshowBoxName);
    streamingsBox ??= Hive.box<StreamingDetailHive>(streamingsBoxName);
  }

  @override
  Future<bool> deleteTvshow(int id) async {
    await _init();
    await _loadBoxes();
    try {
      await tvshowBox!.delete(id);
      final streamings = await streamingsBox!.values
          .where((streaming) => streaming.tvshowId == id);
      if (streamings.isNotEmpty) {
        for (var streaming in streamings) {
          await streamingsBox!.delete(streaming.id);
          log('Streaming of tvshow $id deleted: ${streaming.id}');
        }
      }
      log('Tvshow deleted: $id');
      return true;
    } catch (e) {
      log('Error to delete tvshow: $id', error: e);
      return false;
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    await _init();
    await _loadBoxes();
    try {
      final tvshows = await tvshowBox!.values;
      final streamings = await streamingsBox!.values;
      final List<TvshowDetails> list = [];
      for (TvshowDetails tvshow in tvshows) {
        if (streamings.isNotEmpty) {
          tvshow = tvshow.copyWith(
              streamings: streamings
                  .where((streaming) => streaming.tvshowId == tvshow.id)
                  .map(
                    (streaming) => StreamingDetail(
                      id: streaming.id,
                      streamingName: streaming.streamingName,
                      link: streaming.link,
                      added: streaming.added,
                      leaving: streaming.leaving,
                      country: streaming.country,
                    ),
                  )
                  .toList());
        }
        list.add(tvshow);
      }
      return list;
    } catch (e) {
      log('Error to get tv shows: $e', error: e);
      return [];
    }
  }

  @override
  Future<bool> saveTvshow(TvshowDetails tvshowDetails) async {
    await _init();
    await _loadBoxes();
    if (!tvshowBox!.containsKey(tvshowDetails.id)) {
      try {
        await tvshowBox!.put(tvshowDetails.id, tvshowDetails);

        log('Tvshow ${tvshowDetails.id} saved');

        final savedStreamings = await saveStreamings(tvshowDetails);

        return savedStreamings;
      } catch (e) {
        log('Error to save tvshow ${tvshowDetails.id}', error: e);
        return false;
      }
    }
    return false;
  }

  @override
  Future<bool> saveStreamings(TvshowDetails tvshowDetails) async {
    final streamings = tvshowDetails.streamings;
    final tvshowId = tvshowDetails.id;
    try {
      if (streamings.isNotEmpty) {
        for (int i = 0; i < streamings.length; i++) {
          final streamingHive = StreamingDetailHive(
            id: '${tvshowId}_$i', // Custom unique id
            streamingName: streamings[i].streamingName,
            country: streamings[i].country,
            link: streamings[i].link,
            added: streamings[i].added,
            leaving: streamings[i].leaving,
            tvshowId: tvshowId,
          );

          await streamingsBox!.put(streamingHive.id, streamingHive);
        }
      }
      log('Streamings saved on tvshow ${tvshowId}: ${streamings.length} streamings');
      return true;
    } catch (e) {
      log('Error to save streamings on tv show: ${tvshowId}', error: e);
      return false;
    }
  }
}
