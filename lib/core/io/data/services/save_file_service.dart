import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/io/domain/interfaces/i_manage_files_service.dart';

@LazySingleton(as: IManageFilesService)
class SaveFileService implements IManageFilesService {
  @override
  Future<String> saveFile(String fileName, String json) async {
    return FileSaver.instance.saveAs(
      fileName,
      Uint8List.fromList(json.codeUnits),
      'json',
      MimeType.JSON,
    );
  }
}
