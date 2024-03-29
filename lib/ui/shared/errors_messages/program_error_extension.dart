import 'package:flutter_translate/flutter_translate.dart';

extension ProgramErrorExtension on Error {
  /// References: https://api.flutter.dev/flutter/dart-core/dart-core-library.html#exceptions.
  String getMessage() {
    String internalError = '';
    if (_verifyErrorTypes(ArgumentError)) {
      internalError = translate('app.errors.internal_program_argument');
    }
    if (_verifyErrorTypes(RangeError)) {
      internalError = translate('app.errors.internal_program_range');
    }
    if (_verifyErrorTypes(StateError)) {
      internalError = translate('app.errors.internal_program_state');
    }
    if (_verifyErrorTypes(TypeError)) {
      internalError = translate('app.errors.internal_program_type');
    }

    return translate('app.errors.internal', args: {'detail': internalError});
  }

  bool _verifyErrorTypes(Type errorType) =>
      runtimeType.toString() == '${errorType.toString()}Impl' ||
      runtimeType == errorType;
}
