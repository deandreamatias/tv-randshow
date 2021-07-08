// env.dart
import 'dart:io';

const Map<String, String> environment = <String, String>{
  'baseUrl': 'api.themoviedb.org',
  'apiKey': String.fromEnvironment('API_KEY'),
};
