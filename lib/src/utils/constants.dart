class KeyStorate {
  static const String API_KEY = 'apiKey';
}

class Url {
  static const String API_URL = 'https://api.themoviedb.org';
  static const String API_VERSION = '3';
  static const String API_BASE = '$API_URL/$API_VERSION';

  static const String AUTH_NEW_TOKEN = '$API_BASE/authentication/token/new';
}