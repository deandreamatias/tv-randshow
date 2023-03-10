import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:tv_randshow/ui/widgets/online_image.dart';

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
          borderRadius: const BorderRadius.all(Radius.circular(Styles.small)),
          child: kIsWeb
              ? OnlineImage(url: _checkUrl(url), name: name)
              : _CachedImage(url: _checkUrl(url)),
        ),
        Visibility(
          visible: !isModal,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.all(Styles.small),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(Styles.small)),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
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

class _CachedImage extends StatelessWidget {
  const _CachedImage({required this.url});
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
  return url.isNotEmpty ? Constants.tmdbBaseImage + url : Assets.placeHolder;
}
