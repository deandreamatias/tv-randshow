import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';

extension AppErrorExtension on AppErrorCode {
  String getMessage() {
    String appError = '';
    switch (this) {
      case AppErrorCode.emptyFavs:
        appError = translate('app.errors.app_empty_favs');
        break;
      default:
        appError = translate('app.errors.app_unknown');
    }

    return translate('app.errors.app', args: {'detail': appError});
  }
}
