import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_details.dart';
import 'package:tv_randshow/ui/widgets/delete_button.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';
import 'package:tv_randshow/ui/widgets/random_button.dart';
import 'package:tv_randshow/ui/widgets/tvshow_details_modal.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({super.key, required this.tvshowDetails});
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            right: 8.0,
            left: 8.0,
            top: 8.0,
            bottom: 24.0,
            child: GestureDetector(
              onTap: () => showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) =>
                    TvshowDetailsModal(idTv: tvshowDetails.id),
              ),
              child: ImageBuilder(
                key: Key('${tvshowDetails.id}'),
                name: tvshowDetails.name,
                url: tvshowDetails.posterPath,
                isModal: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: DeleteButton(id: tvshowDetails.id),
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
