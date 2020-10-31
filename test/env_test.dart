import 'package:test/test.dart';

import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';

void main() {
  group('Env -', () {
    test('Verify keys', () {
      FlavorConfig(
          flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));

      expect(FlavorConfig.instance.values.baseUrl, isNotNull);
      expect(FlavorConfig.instance.values.apiKey, isNotNull);

      expect(
          FlavorConfig.instance.values.baseUrl, equals('api.themoviedb.org'));
      expect(FlavorConfig.instance.values.apiKey.isNotEmpty, true);
    });
  });
}
