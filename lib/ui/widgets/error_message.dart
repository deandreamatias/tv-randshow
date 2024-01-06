import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';
import 'package:tv_randshow/core/app/domain/exceptions/app_error.dart';
import 'package:tv_randshow/core/app/domain/exceptions/database_error.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/errors_messages/api_error_extension.dart';
import 'package:tv_randshow/ui/shared/errors_messages/app_error_extension.dart';
import 'package:tv_randshow/ui/shared/errors_messages/database_error_extension.dart';
import 'package:tv_randshow/ui/shared/errors_messages/program_error_extension.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:unicons/unicons.dart';

class ErrorMessage extends StatelessWidget {
  // Apply object to errors.
  // ignore: no-object-declaration
  final Object error;
  final String keyText;
  const ErrorMessage({
    super.key,
    required this.error,
    required this.keyText,
  });

  String _convertErrors() {
    if (error is Error) {
      return (error as Error).getMessage();
    }
    switch (error.runtimeType) {
      case ApiError _:
        return (error as ApiError).code.getMessage();
      case DatabaseError _:
        return (error as DatabaseError).code.getMessage();
      case AppError _:
        return (error as AppError).code.getMessage();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = '${translate(keyText)}\n${_convertErrors()}';

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                UniconsLine.exclamation_octagon,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: Styles.standard),
              Expanded(
                child: Text(
                  errorText,
                  key: Key(keyText),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: Styles.medium),
          TextButton.icon(
            onPressed: () => Helpers.openMail(
              Constants.feedbackEmail,
              mailtoSubject: 'Tv Randshow - Bug report',
              mailtoBody: errorText,
            ),
            icon: const Icon(UniconsLine.fast_mail),
            label: Text(translate('app.send_error')),
          ),
        ],
      ),
    );
  }
}
