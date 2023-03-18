import 'package:flutter_test/flutter_test.dart';
import 'package:tv_randshow/common/models/env.dart';
import 'package:tv_randshow/common/models/flavor_config.dart';

void main() {
  group('Env -', () {
    test('Verify keys', () {
      FlavorConfig(
        flavor: Flavor.dev,
        values: FlavorValues.fromJson(environment),
      );

      expect(
        FlavorConfig.instance.values.baseUrl,
        equals('https://api.themoviedb.org'),
      );
      expect(
        FlavorConfig.instance.values.streamingBaseUrl,
        equals('https://streaming-availability.p.rapidapi.com'),
      );
      expect(FlavorConfig.instance.values.apiKey.isNotEmpty, true);
      expect(FlavorConfig.instance.values.streamingApiKey.isNotEmpty, true);
    });
  });
}
