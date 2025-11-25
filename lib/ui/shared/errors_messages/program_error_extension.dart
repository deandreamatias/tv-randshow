import 'package:easy_localization/easy_localization.dart';

extension ProgramErrorExtension on Error {
  /// References: https://api.flutter.dev/flutter/dart-core/dart-core-library.html#exceptions.
  String getMessage() {
    String internalError = '';
    if (_verifyErrorTypes(ArgumentError)) {
      internalError = tr('app.errors.internal_program_argument');
    }
    if (_verifyErrorTypes(RangeError)) {
      internalError = tr('app.errors.internal_program_range');
    }
    if (_verifyErrorTypes(StateError)) {
      internalError = tr('app.errors.internal_program_state');
    }
    if (_verifyErrorTypes(TypeError)) {
      internalError = tr('app.errors.internal_program_type');
    }

    return tr('app.errors.internal', namedArgs: {'detail': internalError});
  }

  bool _verifyErrorTypes(Type errorType) =>
      runtimeType.toString() == '${errorType.toString()}Impl' ||
      runtimeType == errorType;
}
