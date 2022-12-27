import 'package:flutter_test/flutter_test.dart';
import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';

void main() {
  group('Env -', () {
    test('Verify keys', () {
      FlavorConfig(
          flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));

      expect(FlavorConfig.instance.values.baseUrl,
          equals('https://api.themoviedb.org'));
      expect(FlavorConfig.instance.values.apiKey.isNotEmpty, true);
    });
  });
}
