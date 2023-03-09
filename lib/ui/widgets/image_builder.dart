import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';

const String _baseImage = 'https://image.tmdb.org/t/p/w342/';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.isModal,
    required this.url,
    this.name = '',
  });

  final bool isModal;
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: kIsWeb
              ? OnlineImage(url: _checkUrl(url), name: name)
              : CachedImage(url: _checkUrl(url)),
        ),
        Visibility(
          visible: !isModal,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                color: Theme.of(context).colorScheme.surface.withOpacity(.8),
              ),
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => const Loader(),
      errorWidget: (BuildContext context, String url, Object? error) =>
          Image.asset(Assets.emptyImage),
    );
  }
}

String _checkUrl(String url) {
  return url.isNotEmpty ? _baseImage + url : Assets.placeHolder;
}
