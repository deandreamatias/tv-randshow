import 'package:easy_localization/easy_localization.dart';
import 'package:tv_randshow/core/app/domain/exceptions/database_error.dart';

extension DatabaseErrorExtension on DatabaseErrorCode {
  String getMessage() {
    final databaseError = switch (this) {
      DatabaseErrorCode.init => tr('app.errors.database_init'),
      DatabaseErrorCode.delete => tr('app.errors.database_delete'),
      DatabaseErrorCode.read => tr('app.errors.database_read'),
      DatabaseErrorCode.unknown => tr('app.errors.database_unknown'),
    };

    return tr('app.errors.database', namedArgs: {'detail': databaseError});
  }
}
