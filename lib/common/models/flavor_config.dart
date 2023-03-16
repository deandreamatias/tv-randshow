// ignore_for_file: avoid-non-null-assertion
class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;
  static FlavorConfig get instance => _instance!;
  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance ??=
        FlavorConfig._internal(flavor, enumName(flavor.toString()), values);

    return _instance!;
  }
  FlavorConfig._internal(this.flavor, this.name, this.values);

  static String enumName(String enumToString) {
    final List<String> paths = enumToString.split('.');

    return paths.last;
  }

  static bool isProduction() => _instance!.flavor == Flavor.prod;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
}

enum Flavor { dev, prod }

class FlavorValues {
  final String baseUrl;
  final String apiKey;
  final String streamingBaseUrl;
  final String streamingApiKey;

  FlavorValues({
    required this.baseUrl,
    required this.apiKey,
    required this.streamingApiKey,
    required this.streamingBaseUrl,
  });

  static FlavorValues fromJson(Map<String, dynamic> json) {
    return FlavorValues(
      baseUrl: json['baseUrl'] as String,
      apiKey: json['apiKey'] as String,
      streamingBaseUrl: json['streamingBaseUrl'] as String,
      streamingApiKey: json['streamingApiKey'] as String,
    );
  }
}
