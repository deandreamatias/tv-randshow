import 'package:flutter/material.dart';

class TextTitleLarge extends StatelessWidget {
  final String label;
  final TextAlign? textAlign;
  const TextTitleLarge(this.label, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
