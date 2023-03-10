import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioService {
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
      queryParameters: queryParams,
    ),
  );
  DioService(this.baseUrl, {this.headers, this.queryParams});

  Future<Map<String, dynamic>> get(
    String path,
    Map<String, dynamic> dataMap,
  ) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: dataMap,
      );
      if (response.data is String) {
        return jsonDecode(response.data) ?? {};
      }
      if (response.data is Map) {
        return response.data ?? {};
      }

      return {};
    } on DioError catch (e) {
      log('Error to get $path: ${e.message}', error: e);

      return {};
    }
  }
}
