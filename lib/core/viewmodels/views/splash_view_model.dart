import 'package:flutter/widgets.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import '../../services/secure_storage_service.dart';
import '../base_model.dart';

class SplashViewModel extends BaseModel {
  SplashViewModel({
    @required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;
  final SecureStorageService _secureStorageService;

  Future<void> init() async {
    setBusy(true);
    await _secureStorageService.writeStorage(
        KeyStore.API_KEY, FlavorConfig.instance.values.apiKey);
    setBusy(false);
  }
}
