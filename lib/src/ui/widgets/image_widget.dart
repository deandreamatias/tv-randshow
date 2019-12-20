import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv_randshow/src/utils/constants.dart';

import 'package:tv_randshow/src/utils/styles.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({this.name, this.url, this.isModal});
  final String name;
  final String url;
  final bool isModal;

  // TODO(deandreamatias): Change text color when no image
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
                      borderRadius: BORDER_RADIUS, color: Colors.black38),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: StyleColor.WHITE, fontWeight: FontWeight.w600),
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
      placeholder: (BuildContext context, String url) => const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
      errorWidget: (BuildContext context, String url, Object error) =>
          Image.asset(Images.EMPTY_IMAGE),
    );
  }
}
