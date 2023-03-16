import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/ui/containers/tvshow_detail/tvshow_details_modal.dart';
import 'package:tv_randshow/ui/features/home/widgets/delete_button.dart';
import 'package:tv_randshow/ui/features/home/widgets/random_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({super.key, required this.tvshowDetails});
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Styles.small)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            right: Styles.small,
            left: Styles.small,
            // Ignore repetead.
            // ignore: no-equal-arguments
            top: Styles.small,
            bottom: Styles.large,
            child: GestureDetector(
              onTap: () => showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) =>
                    TvshowDetailsModal(idTv: tvshowDetails.id),
              ),
              child: ImageBuilder(
                key: Key(
                  '${tvshowDetails.posterPath}${tvshowDetails.id.toString()}',
                ),
                name: tvshowDetails.name,
                url: tvshowDetails.posterPath,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: DeleteButton(idTv: tvshowDetails.id),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RandomButton(idTv: tvshowDetails.id),
          ),
        ],
      ),
    );
  }
}
