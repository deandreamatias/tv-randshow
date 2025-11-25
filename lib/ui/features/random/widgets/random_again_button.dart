import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';

class RandomAgainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelKey;
  const RandomAgainButton({
    super.key,
    required this.onPressed,
    required this.labelKey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(CustomIcons.diceMultiple),
      label: Text(context.tr(labelKey), key: Key(labelKey)),
      onPressed: onPressed,
    );
  }
}
