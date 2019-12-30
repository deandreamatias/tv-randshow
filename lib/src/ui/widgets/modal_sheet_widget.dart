import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../data/tvshow_details.dart';
import '../../utils/styles.dart';
import 'fav_button_widget.dart';
import 'image_widget.dart';
import 'info_box_widget.dart';
import 'random_button_widget.dart';

class MenuPanelWidget extends StatelessWidget {
  const MenuPanelWidget({this.tvshowDetails, this.inDatabase});
  final TvshowDetails tvshowDetails;
  final bool inDatabase;
  // TODO(deandreamatias): Persist state of button on search and fav widgets

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 24),
        padding: DEFAULT_INSESTS,
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(16.0),
          ),
          color: StyleColor.WHITE,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ImageWidget(
                          url: tvshowDetails.posterPath, isModal: true),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          tvshowDetails.name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: StyleText.TITLE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  InfoBoxWidget(
                      typeInfo: 0,
                      value: tvshowDetails.numberOfSeasons ?? '--'),
                  InfoBoxWidget(
                      typeInfo: 1,
                      value: tvshowDetails.numberOfEpisodes ?? '--'),
                  InfoBoxWidget(
                      typeInfo: 2,
                      value: tvshowDetails.episodeRunTime.isNotEmpty
                          ? tvshowDetails.episodeRunTime.first
                          : 0)
                ],
              ),
            ),
            Text(FlutterI18n.translate(context, 'app.modal.overview'),
                style: StyleText.MESSAGES),
            const SizedBox(height: 8.0),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Text(tvshowDetails.overview),
              ),
            ),
          ],
        ),
      ),
      if (inDatabase)
        RandomButtonWidget(tvshowDetails: tvshowDetails)
      else
        FavButtonWidget(id: tvshowDetails.id),
    ]);
  }
}
