import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';
import 'package:tv_randshow/core/app/domain/exceptions/database_error.dart';
import 'package:tv_randshow/ui/shared/errors_messages/api_error_extension.dart';
import 'package:tv_randshow/ui/shared/errors_messages/database_error_extension.dart';
import 'package:tv_randshow/ui/shared/errors_messages/program_error_extension.dart';
import 'package:tv_randshow/ui/shared/show_snackbar.dart';

class AsyncValueExtension {
  static Future<AsyncValue<T>> catchGuard<T>(
    Future<T> Function() future,
  ) async {
    try {
      return AsyncValue.data(await future());
    } on ApiError catch (e, stackTrace) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: stackTrace,
      );
      showSnackBar(e.code.getMessage());

      return AsyncValue.error(e, stackTrace);
    } on DatabaseError catch (e, stackTrace) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: stackTrace,
      );
      showSnackBar(e.code.getMessage());

      return AsyncValue.error(e, stackTrace);
    } on Error catch (e, stackTrace) {
      debugPrintStack(
        label: e.getMessage(),
        stackTrace: stackTrace,
      );

      showSnackBar(e.getMessage());

      return AsyncValue.error(e, stackTrace);
    } catch (e, stackTrace) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: stackTrace,
      );

      return AsyncValue.error(e, stackTrace);
    }
  }
}
