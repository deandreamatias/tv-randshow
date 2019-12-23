import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/utils/constants.dart';

class AppModel extends BaseModel {
  void init() {
    secureStorage.writeStorage(
        KeyStore.API_KEY, FlavorConfig.instance.values.apiKey);
  }
}
