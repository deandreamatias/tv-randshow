import 'package:easy_localization/easy_localization.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';

extension AppErrorExtension on AppErrorCode {
  String getMessage() {
    final appError = switch (this) {
      AppErrorCode.emptyFavs => tr('app.errors.app_empty_favs'),
      AppErrorCode.invalidEpisodeNumber => tr('app.errors.app_invalid_episode'),
      AppErrorCode.invalidSeasonNumber => tr('app.errors.app_invalid_season'),
    };

    return tr('app.errors.app', namedArgs: {'detail': appError});
  }
}
