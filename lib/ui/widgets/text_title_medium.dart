import 'package:flutter/material.dart';

class TextTitleMedium extends StatelessWidget {
  final String label;
  const TextTitleMedium(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: Theme.of(context).textTheme.titleMedium);
  }
}
