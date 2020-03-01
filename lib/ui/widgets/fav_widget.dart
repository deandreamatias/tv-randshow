import 'package:flutter/material.dart';

import '../../core/models/tvshow_details.dart';
import '../shared/styles.dart';
import 'cached_image.dart';
import 'delete_button.dart';
import 'modal_sheet.dart';
import 'random_button.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({Key key, @required this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BORDER_RADIUS),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            right: 8.0,
            left: 8.0,
            top: 8.0,
            bottom: 24.0,
            child: GestureDetector(
              onTap: () => showModalBottomSheet<Container>(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                elevation: 0.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(16.0)),
                ),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 424,
                    child: ModalSheet(
                      idTv: tvshowDetails.id,
                      inDatabase: true,
                    ),
                  );
                },
              ),
              child: CachedImage(
                  name: tvshowDetails.name,
                  url: tvshowDetails.posterPath,
                  isModal: false),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: DeleteButton(idRow: tvshowDetails.rowId),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RandomButton(tvshowDetails: tvshowDetails),
          ),
        ],
      ),
    );
  }
}
