// ignore_for_file: avoid-non-null-assertion

import 'package:flutter/material.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/widgets/snackbar_style.dart';

void showSnackBar(
  String message, {
  String details = '',
  SnackBarStyle style = SnackBarStyle.error,
}) {
  final snackBarKey = locator.get<GlobalKey<ScaffoldMessengerState>>();

  if (snackBarKey.currentState != null) {
    final SnackBar snackBar = StyledSnackBar.styledSnackBar(
      snackBarKey.currentState!.context,
      message,
      details: details,
      style: style,
    );
    // Do not use this return value.
    // ignore: avoid-ignoring-return-values
    snackBarKey.currentState!.showSnackBar(snackBar);
  }
}
