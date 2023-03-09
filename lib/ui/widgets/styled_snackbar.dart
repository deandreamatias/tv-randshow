import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_it/get_it.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

enum SnackBarStyle { info, error }

SnackBar styledSnackBar(
  BuildContext context,
  String message, {
  String details = '',
  SnackBarStyle style = SnackBarStyle.info,
}) {
  Color? bgColor;
  Color? labelColor;

  switch (style) {
    case SnackBarStyle.error:
      bgColor = Theme.of(context).colorScheme.error;
      labelColor = Theme.of(context).colorScheme.onError;
      break;
    default:
      bgColor = null;
      labelColor = null;
  }

  return SnackBar(
    margin: const EdgeInsets.all(24),
    behavior: SnackBarBehavior.floating,
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    content: Text(message),
    action: style == SnackBarStyle.error
        ? SnackBarAction(
            label: translate('app.report_action'),
            textColor: labelColor,
            onPressed: () {
              Helpers.openMail(
                Constants.feedbackEmail,
                mailtoSubject: 'Tv Randshow - Bug report',
                mailtoBody: details,
              );
              GetIt.I
                  .get<GlobalKey<ScaffoldMessengerState>>()
                  .currentState
                  ?.hideCurrentSnackBar();
            },
          )
        : null,
  );
}
