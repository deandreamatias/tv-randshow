import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/app/domain/exceptions/api_error.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/errors_messages/api_error_extension.dart';
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
    switch (error.runtimeType) {
      case ApiError:
        return (error as ApiError).code.getMessage();
      case Error:
        return (error as Error).getMessage();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = '${translate(keyText)}\n${_convertErrors()}';

    return Center(
      child: Column(
        children: [
          Icon(
            UniconsLine.exclamation_octagon,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: Styles.standard),
          Text(
            errorText,
            key: Key(keyText),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Styles.standard),
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
