import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/ui/containers/tvshow_detail/tvshow_details_modal.dart';
import 'package:tv_randshow/ui/features/search/widgets/save_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.result});
  final Result result;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: result.isOnAir ? 1.0 : 0.38,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Styles.small)),
        ),
        child:
            result.isOnAir
                ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      right: 0.0,
                      left: 0.0,
                      top: 0.0,
                      bottom: Styles.large,
                      child: _ResultImage(result: result),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SaveButton(tvId: result.id),
                    ),
                  ],
                )
                : _ResultImage(result: result),
      ),
    );
  }
}

class _ResultImage extends StatelessWidget {
  const _ResultImage({required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          result.isOnAir
              ? () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder:
                      (BuildContext builder) => TvshowDetailsModal(
                        idTv: result.id,
                        showRandom: false,
                      ),
                );
              }
              : null,
      child: ImageBuilder(name: result.name, url: result.posterPath),
    );
  }
}
