import '../../config/flavor_config.dart';
import '../utils/constants.dart';
import 'base_model.dart';

class AppModel extends BaseModel {
  void init() {
    secureStorage.writeStorage(
        KeyStore.API_KEY, FlavorConfig.instance.values.apiKey);
  }
}
