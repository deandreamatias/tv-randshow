import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tv_randshow/core/app/domain/interfaces/permissions_service.dart';

class PermissionsService extends IPermissionsService {
  @override
  Future<bool> getStoragePermission() async {
    if (kIsWeb) return true;

    bool status = await Permission.storage.isGranted;
    if (status) return true;
    final permission = await Permission.storage.request();

    return permission.isGranted;
  }
}
