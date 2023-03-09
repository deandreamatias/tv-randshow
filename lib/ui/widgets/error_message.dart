import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
    return Center(
      child: Column(
        children: [
          const Icon(UniconsLine.exclamation_octagon),
          const SizedBox(height: 16),
          Text(
            '${translate(keyText)}\n$error',
            key: Key(keyText),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
