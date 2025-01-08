import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';

extension ApiErrorExtension on ApiErrorCode {
  String getMessage() {
    String apiError = '';
    switch (this) {
      case ApiErrorCode.badRequest:
        apiError = translate('app.errors.bad_request');
        break;
      case ApiErrorCode.unauthorized:
        apiError = translate('app.errors.unauthorized');
        break;
      case ApiErrorCode.forbidden:
        apiError = translate('app.errors.forbidden');
        break;
      case ApiErrorCode.notFound:
        apiError = translate('app.errors.not_found');
        break;
      case ApiErrorCode.serverError:
        apiError = translate('app.errors.internal_server_tvshows');
        break;
      case ApiErrorCode.generalError: 
        apiError = translate('app.errors.global');
    }

    return translate('app.errors.api', args: {'detail': apiError});
  }
}
