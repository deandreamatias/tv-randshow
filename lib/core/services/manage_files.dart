import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tv_randshow/core/models/file.dart';

import 'database_service.dart';

@lazySingleton
class ManageFiles {
  ManageFiles({
    DatabaseService databaseService,
  }) : _databaseService = databaseService;
  final DatabaseService _databaseService;

  Future<bool> saveFile() async {
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      bool status = await Permission.storage.isGranted;
      if (!status) await Permission.storage.request();
    }
    final favTvshows = await _databaseService.queryList();
    if (favTvshows == null || favTvshows.isEmpty) return false;

    final jsonFavTvshows = File(tvshows: favTvshows).toRawJson();

    final nowDateTime = DateTime.now().toLocal().toIso8601String().split('.');
    final fileName = 'tvrandshow-${nowDateTime[0]}';

    final downloadPath = await FileSaver.instance.saveFile(
      fileName,
      Uint8List.fromList(jsonFavTvshows.codeUnits),
      'json',
      mimeType: MimeType.JSON,
    );

    return downloadPath != null && downloadPath.isNotEmpty;
  }
}
