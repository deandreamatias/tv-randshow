import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';
import 'package:unicons/unicons.dart';

class ErrorMessage extends StatelessWidget {
  final String error;
  final String keyText;
  const ErrorMessage({
    super.key,
    this.error = '',
    required this.keyText,
  });

  @override
  Widget build(BuildContext context) {
    final errorText = '${translate(keyText)}\n$error';
    return Center(
      child: Column(
        children: [
          const Icon(UniconsLine.exclamation_octagon),
          const SizedBox(height: 16),
          Text(
            errorText,
            key: Key(keyText),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => Helpers.openMail(
              Constants.feedbackEmail,
              mailtoSubject: 'Tv Randshow - Bug report',
              mailtoBody: errorText,
            ),
            icon: const Icon(UniconsLine.fast_mail),
            label: Text(translate('app.send_error')),
          )
        ],
      ),
    );
  }
}
