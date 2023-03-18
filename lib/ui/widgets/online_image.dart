import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/assets.dart';

class OnlineImage extends StatelessWidget {
  const OnlineImage({
    super.key,
    required this.url,
    required this.name,
  });

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      semanticLabel: name,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) =>
              Image.asset(Assets.emptyImage),
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) return child;

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
    );
  }
}
