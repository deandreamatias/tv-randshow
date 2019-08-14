import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Flavor { DEV, PROD }

class FlavorValues {
  FlavorValues({@required this.baseUrl, this.apiKey});
  final String baseUrl;
  final String apiKey;
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig(
      {@required Flavor flavor, @required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, enumName(flavor.toString()), values);
    return _instance;
  }

  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PROD;
  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
}
