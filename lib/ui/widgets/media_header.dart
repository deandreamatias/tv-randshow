import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';

class MediaHeader extends StatelessWidget {
  final String title;
  final String imagePath;
  final Widget? child;

  const MediaHeader({
    super.key,
    required this.title,
    required this.imagePath,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ImageBuilder(url: imagePath, name: title, isModal: true),
        ),
        const SizedBox(width: Styles.small),
        Expanded(
          // Allow value.
          // ignore: no-magic-number
          flex: 3,
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  // Allow value.
                  // ignore: no-magic-number
                  maxLines: 3,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: Styles.small),
                child ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
