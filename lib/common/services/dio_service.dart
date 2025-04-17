import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class DioService {
  /// Use [baseUrl] to config a base url of api, like `https://api.tmdb.com`.
  final String baseUrl;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;

  /// Optional [catchErrors] to get DioError. This is usuful when need
  /// transform a DioError to custom error.
  final void Function(DioException)? catchErrors;
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: headers,
      queryParameters: queryParams,
    ),
  );
  DioService(this.baseUrl, {this.headers, this.queryParams, this.catchErrors});

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic> query = const {},
  }) async {
    try {
      final Response response = await _dio.get(path, queryParameters: query);
      if (response.data is String) {
        return jsonDecode(response.data) ?? {};
      }
      if (response.data is Map) {
        return response.data ?? {};
      }

      return {};
    } on DioException catch (e) {
      log('${e.message.toString()} - ${e.response.toString()}');
      if (catchErrors == null) {
        rethrow;
      }
      catchErrors?.call(e);

      return {};
    } catch (e) {
      rethrow;
    }
  }
}
