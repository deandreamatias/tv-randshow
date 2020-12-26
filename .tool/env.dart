import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final Map<String, dynamic> config = <String, dynamic>{
    'baseUrl': 'api.themoviedb.org',
    'apiKey': Platform.environment['API_KEY_TMDB'],
  };

  final filename = 'lib/config/env.dart';
  File(filename).writeAsString(
      'const Map<String, String> environment = <String, String>${json.encode(config)};');
}
