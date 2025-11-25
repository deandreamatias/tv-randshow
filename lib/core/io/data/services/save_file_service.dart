import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';

@LazySingleton(as: IManageFilesService)
class SaveFileService implements IManageFilesService {
  @override
  Future<String> saveFile(String fileName, String json) async {
    final result = kIsWeb
        ? await FileSaver.instance.saveFile(
            name: fileName,
            bytes: Uint8List.fromList(json.codeUnits),
            fileExtension: 'json',
            mimeType: MimeType.json,
          )
        : await FileSaver.instance.saveAs(
            name: fileName,
            bytes: Uint8List.fromList(json.codeUnits),
            fileExtension: 'json',
            mimeType: MimeType.json,
          );
    return result ?? '';
  }
}
