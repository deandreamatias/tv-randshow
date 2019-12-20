import 'package:tv_randshow/config/flavor_config.dart';

class KeyStorate {
  static const String API_KEY = 'apiKey';
}

String apiUrl = FlavorConfig.instance.values.baseUrl;
const String BASE_IMAGE = 'https://image.tmdb.org/t/p/w342/';
const String API_VERSION = '/3';
const String AUTH_NEW_TOKEN = '$API_VERSION/authentication/token/new';
const String TVSHOW_SEARCH = '$API_VERSION/search/tv';
const String TVSHOW_DETAILS = '$API_VERSION/tv/';
const String TVSHOW_DETAILS_SEASON = '/season/';

class Images {
  static const String EMPTY_IMAGE = 'assets/img/no_image.png';
  static const String PLACE_HOLDER = 'https://via.placeholder.com/344';
}
