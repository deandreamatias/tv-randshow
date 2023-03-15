import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/styles.dart';

@immutable
class FabActionButton extends StatelessWidget {
  const FabActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondaryContainer,
      elevation: Styles.xsmall,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondaryContainer,
      ),
    );
  }
}
