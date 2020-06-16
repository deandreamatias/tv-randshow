import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/utils/constants.dart';
import '../shared/styles.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    Key key,
    @required this.isModal,
    @required this.url,
    this.name,
  }) : super(key: key);

  final bool isModal;
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BORDER_RADIUS,
          child: kIsWeb
              ? OnlineImage(url: _checkUrl(url), name: name)
              : CachedImage(url: _checkUrl(url), name: name),
        ),
        Visibility(
          visible: !isModal,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: SMALL_INSESTS,
              decoration: const BoxDecoration(
                borderRadius: BORDER_RADIUS,
                color: Colors.black54,
              ),
              child: Text(
                name,
                style: StyleText.NAME,
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
    Key key,
    @required this.url,
    @required this.name,
  }) : super(key: key);

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      semanticLabel: name,
      errorBuilder:
          (BuildContext context, Object error, StackTrace stackTrace) =>
              Image.asset(Assets.EMPTY_IMAGE),
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }
}

class CachedImage extends StatelessWidget {
  const CachedImage({this.name, this.url});
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (BuildContext context, String url, Object error) =>
          Image.asset(Assets.EMPTY_IMAGE),
    );
  }
}

String _checkUrl(String url) {
  return url != null
      ? url.isNotEmpty ? BASE_IMAGE + url : Assets.PLACE_HOLDER
      : Assets.PLACE_HOLDER;
}
