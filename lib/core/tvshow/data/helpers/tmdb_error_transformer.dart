import 'package:dio/dio.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';

class TmdbErrorTransformer {
  static void transformDioErros(DioError error) {
    final String apiErrorMessage = _getMessage(error.response);

    switch (error.response?.statusCode) {
      case 400:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.badRequest,
        );
      case 401:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.unauthorized,
        );
      case 403:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.forbidden,
        );
      case 404:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.notFound,
        );
      case 500:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.serverError,
        );
      default:
        throw ApiError(
          message: apiErrorMessage,
          code: ApiErrorCode.generalError,
        );
    }
  }

  static String _getMessage(Response? response) {
    String apiErrorMessage = '';
    if (response != null) {
      final data = response.data;
      if (data is Map) {
        apiErrorMessage = data['status_message'] ?? data.toString();
      }
      if (data is List) {
        apiErrorMessage = data.first.toString();
      }
      if (data is String) {
        apiErrorMessage = data;
      }
      if (apiErrorMessage.isEmpty) {
        apiErrorMessage = response.statusMessage ?? '';
      }
    } else {
      apiErrorMessage = 'Empty or invalid response';
    }

    return apiErrorMessage;
  }
}
