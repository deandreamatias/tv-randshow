import 'package:easy_localization/easy_localization.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';

extension ApiErrorExtension on ApiErrorCode {
  String getMessage() {
    final apiError = switch (this) {
      ApiErrorCode.badRequest => tr('app.errors.bad_request'),
      ApiErrorCode.unauthorized => tr('app.errors.unauthorized'),
      ApiErrorCode.forbidden => tr('app.errors.forbidden'),
      ApiErrorCode.notFound => tr('app.errors.not_found'),
      ApiErrorCode.serverError => tr('app.errors.internal_server_tvshows'),
      ApiErrorCode.generalError => tr('app.errors.global'),
    };

    return tr('app.errors.api', namedArgs: {'detail': apiError});
  }
}
