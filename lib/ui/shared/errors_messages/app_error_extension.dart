import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';

extension AppErrorExtension on AppErrorCode {
  String getMessage() {
    String appError = '';
    switch (this) {
      case AppErrorCode.emptyFavs:
        appError = translate('app.errors.app_empty_favs');
        break;
      case AppErrorCode.invalidEpisodeNumber:
        appError = translate('app.errors.app_invalid_episode');
        break;
      case AppErrorCode.invalidSeasonNumber:
        appError = translate('app.errors.app_invalid_season');
    }

    return translate('app.errors.app', args: {'detail': appError});
  }
}
