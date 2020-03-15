import '../../config/flavor_config.dart';

class RoutePaths {
  static const String TAB = '/';
  static const String SPLASH = 'splash';
  static const String LOADING = 'loading';
  static const String RESULT = 'result';
}

class KeyStore {
  static const String API_KEY = 'apiKey';
}

String apiUrl = FlavorConfig.instance.values.baseUrl;
const String BASE_IMAGE = 'https://image.tmdb.org/t/p/w342/';
const String API_VERSION = '/3';
const String TVSHOW_SEARCH = '$API_VERSION/search/tv';
const String TVSHOW_DETAILS = '$API_VERSION/tv/';
const String TVSHOW_DETAILS_SEASON = '/season/';

class Images {
  static const String EMPTY_IMAGE = 'assets/img/no_image.webp';
  static const String LOADING = 'assets/img/loading.flr';
  static const String PLACE_HOLDER =
      'https://via.placeholder.com/288x256?text=no+image';
}
