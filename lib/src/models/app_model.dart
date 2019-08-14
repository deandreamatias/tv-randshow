import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/resources/secure_storage.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class AppModel extends BaseModel {
  init() {
    SecureStorage().writeStorage(KeyStorate.API_KEY, FlavorConfig.instance.values.apiKey);
  }
}
