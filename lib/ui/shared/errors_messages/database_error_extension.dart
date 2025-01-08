import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/database_error.dart';

extension DatabaseErrorExtension on DatabaseErrorCode {
  String getMessage() {
    String databaseError = '';
    switch (this) {
      case DatabaseErrorCode.init:
        databaseError = translate('app.errors.database_init');
        break;
      case DatabaseErrorCode.delete:
        databaseError = translate('app.errors.database_delete');
        break;
      case DatabaseErrorCode.read:
        databaseError = translate('app.errors.database_read');
        break;
      case DatabaseErrorCode.unknown:
        databaseError = translate('app.errors.database_unknown');
    }

    return translate('app.errors.database', args: {'detail': databaseError});
  }
}
