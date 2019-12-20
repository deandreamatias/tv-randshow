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

class ImagePath {
  static const String emptyTvShow = 'assets/img/no_image.png';
}
