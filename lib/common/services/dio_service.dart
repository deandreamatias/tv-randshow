import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioService {
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  late Dio _dio;
  DioService(this.baseUrl, {this.headers, this.queryParams}) {
    _initDio();
  }

  void _initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
      queryParameters: queryParams,
    );
    _dio = Dio(options);
  }

  Future<Map<String, dynamic>> get(
    String path,
    Map<String, dynamic> dataMap,
  ) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
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
