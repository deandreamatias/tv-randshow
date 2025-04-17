// ignore_for_file: avoid-non-null-assertion

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';
import 'package:tv_randshow/core/app/domain/exceptions/database_error.dart';
import 'package:tv_randshow/core/streaming/data/models/streaming_detail_hive.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/domain/interfaces/i_local_repository.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';

const int tvshowDetailsHiveTypeId = 1;
const int streamingDetailHiveTypeId = 2;

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  Box<TvshowDetails>? tvshowBox;
  Box<StreamingDetailHive>? streamingsBox;
  final tvshowBoxName =
      FlavorConfig.isDevelopment() ? 'tvshowfavdev' : 'tvshowfav';
  final streamingsBoxName =
      FlavorConfig.isDevelopment() ? 'streamingsdev' : 'streamings';

  @override
  Future<bool> deleteTvshow(int id) async {
    await _init();
    await _loadBoxes();
    try {
      await tvshowBox!.delete(id);
      final streamings = streamingsBox!.values.where(
        (streaming) => streaming.tvshowId == id,
      );
      if (streamings.isNotEmpty) {
        for (var streaming in streamings) {
          await streamingsBox!.delete(streaming.id);
          log('Streaming of tvshow $id deleted: ${streaming.id}');
        }
      }
      log('Tvshow deleted: $id');

      return true;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        DatabaseError(code: DatabaseErrorCode.delete, message: e.toString()),
        stackTrace,
      );
    }
  }

  @override
  Future<List<TvshowDetails>> getTvshows() async {
    await _init();
    await _loadBoxes();
    try {
      final tvshows = tvshowBox!.values;
      final streamings = streamingsBox!.values;
      final List<TvshowDetails> list = [];
      for (TvshowDetails tvshow in tvshows) {
        if (streamings.isNotEmpty) {
          tvshow = tvshow.copyWith(
            streamings:
                streamings
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
                    .toList(),
          );
        }
        list.add(tvshow);
      }

      return list;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        DatabaseError(code: DatabaseErrorCode.read, message: e.toString()),
        stackTrace,
      );
    }
  }

  @override
  Future<void> saveTvshow(TvshowDetails tvshowDetails) async {
    await _init();
    await _loadBoxes();
    if (!tvshowBox!.containsKey(tvshowDetails.id)) {
      await tvshowBox!.put(tvshowDetails.id, tvshowDetails);

      log('Tvshow ${tvshowDetails.id} saved');

      await saveStreamings(tvshowDetails);
    }
  }

  @override
  Future<void> saveStreamings(TvshowDetails tvshowDetails) async {
    final streamings = tvshowDetails.streamings;
    final tvshowId = tvshowDetails.id;

    if (streamings.isNotEmpty) {
      for (int index = 0; index < streamings.length; index++) {
        final streamingHive = StreamingDetailHive(
          id: '${tvshowId}_$index', // Custom unique id.
          streamingName: streamings[index].streamingName,
          country: streamings[index].country,
          link: streamings[index].link,
          added: streamings[index].added,
          leaving: streamings[index].leaving,
          tvshowId: tvshowId,
        );

        await streamingsBox!.put(streamingHive.id, streamingHive);
      }
    }
    log(
      'Streamings saved on tvshow $tvshowId: ${streamings.length} streamings',
    );
  }

  @override
  Future<TvshowDetails> getTvshow(int id) async {
    await _init();
    await _loadBoxes();
    try {
      TvshowDetails? tvshow = tvshowBox!.get(id);
      if (tvshow == null) {
        throw DatabaseError(
          code: DatabaseErrorCode.read,
          message: 'Do not exist the tvshow with id $id',
        );
      }
      final streamings = streamingsBox!.values;
      if (streamings.isNotEmpty) {
        tvshow = tvshow.copyWith(
          streamings:
              streamings
                  .where((streaming) => streaming.tvshowId == tvshow?.id)
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
                  .toList(),
        );
      }

      return tvshow;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        DatabaseError(code: DatabaseErrorCode.read, message: e.toString()),
        stackTrace,
      );
    }
  }

  Future<void> _init() async {
    if (tvshowBox != null && streamingsBox != null) {
      return;
    }
    if (kIsWeb) {
      _registerAdapters();
    } else {
      Directory? documentsDirectory;
      try {
        if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
          documentsDirectory = await getApplicationDocumentsDirectory();
        }
        if (Platform.isAndroid) {
          documentsDirectory = await getExternalStorageDirectory();
        }
      } catch (e, stackTrace) {
        Error.throwWithStackTrace(
          DatabaseError(code: DatabaseErrorCode.init, message: e.toString()),
          stackTrace,
        );
      }
      Hive.init(documentsDirectory?.path ?? '');
      _registerAdapters();
    }
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(tvshowDetailsHiveTypeId)) {
      Hive.registerAdapter(TvshowDetailsAdapter());
    }
    if (!Hive.isAdapterRegistered(streamingDetailHiveTypeId)) {
      Hive.registerAdapter(StreamingDetailHiveAdapter());
    }
  }

  Future<void> _loadBoxes() async {
    if (!Hive.isBoxOpen(tvshowBoxName)) {
      tvshowBox = await Hive.openBox<TvshowDetails>(tvshowBoxName);
    }
    if (!Hive.isBoxOpen(streamingsBoxName)) {
      streamingsBox = await Hive.openBox<StreamingDetailHive>(
        streamingsBoxName,
      );
    }
    tvshowBox ??= Hive.box<TvshowDetails>(tvshowBoxName);
    streamingsBox ??= Hive.box<StreamingDetailHive>(streamingsBoxName);
  }
}
