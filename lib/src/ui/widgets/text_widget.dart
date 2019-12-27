import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../utils/styles.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(FlutterI18n.translate(context, text),
          style: StyleText.MESSAGES, textAlign: TextAlign.center),
    );
  }
}
