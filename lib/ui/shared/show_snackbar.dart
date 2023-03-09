import 'package:flutter/material.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/widgets/styled_snackbar.dart';

void showSnackBar(
  String message, {
  String details = '',
  SnackBarStyle style = SnackBarStyle.error,
}) {
  final snackBarKey = locator.get<GlobalKey<ScaffoldMessengerState>>();

  if (snackBarKey.currentState != null) {
    final SnackBar snackBar = styledSnackBar(
      snackBarKey.currentState!.context,
      message,
      style: style,
    );
    snackBarKey.currentState!.showSnackBar(snackBar);
  }
}
