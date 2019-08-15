import 'package:tv_randshow/config/flavor_config.dart';

class KeyStorate {
  static const String API_KEY = 'apiKey';
}

class Url {
  static String apiUrl = FlavorConfig.instance.values.baseUrl;
  static const String API_VERSION = '/3';

  static const String AUTH_NEW_TOKEN = '$API_VERSION/authentication/token/new';
  static const String TVSHOW_SEARCH = '$API_VERSION/search/tv';
}