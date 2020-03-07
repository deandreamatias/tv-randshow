import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/utils/constants.dart';
import '../shared/styles.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({this.name, this.url, this.isModal});
  final String name;
  final String url;
  final bool isModal;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url != null
          ? url.isNotEmpty ? BASE_IMAGE + url : Images.PLACE_HOLDER
          : Images.PLACE_HOLDER,
      imageBuilder:
          (BuildContext context, ImageProvider<dynamic> imageProvider) =>
              Container(
        height: isModal ? null : 128.0,
        width: isModal ? null : 144.0,
        child: isModal
            ? null
            : Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: SMALL_INSESTS,
                  decoration: BoxDecoration(
                    borderRadius: BORDER_RADIUS,
                    color: Colors.black54,
                  ),
                  child: Text(
                    name,
                    style: StyleText.NAME,
                  ),
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BORDER_RADIUS,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          ),
        ),
      ),
      placeholder: (BuildContext context, String url) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 36.0),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (BuildContext context, String url, Object error) =>
          Image.asset(Images.EMPTY_IMAGE),
    );
  }
}
