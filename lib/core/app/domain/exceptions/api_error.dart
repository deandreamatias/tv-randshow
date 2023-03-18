class ApiError implements Exception {
  final String message;
  final ApiErrorCode code;

  const ApiError({
    this.message = '',
    required this.code,
  });

  @override
  String toString() {
    return '${code.toString()} - $message';
  }
}

enum ApiErrorCode {
  badRequest,
  forbidden,
  unauthorized,
  serverError,
  generalError,
  notFound,
}
