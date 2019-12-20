import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/ui/widgets/info_box_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class MenuPanelWidget extends StatelessWidget {
  const MenuPanelWidget(this.tvshowDetails, this.inDatabase, {Key key})
      : super(key: key);
  final TvshowDetails tvshowDetails;
  final bool inDatabase;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          // Positioned(
          //   top: -22.5,
          //   child: RaisedButton.icon(
          //     icon: Icon(Unicons.favourite, color: StyleColor.PRIMARY),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0),
          //         side: BorderSide(color: StyleColor.PRIMARY)),
          //     color: StyleColor.WHITE,
          //     label: Text('Add to fav',
          //         style: TextStyle(color: StyleColor.PRIMARY)),
          //     onPressed: () {
          //       if (inDatabase) {
          //       } else {
          //         ScopedModel.of<SearchModel>(context)
          //             .insertDatabase(tvshowDetails);
          //       }
          //     },
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: SMALL_INSESTS,
                          decoration: BoxDecoration(
                            borderRadius: BORDER_RADIUS,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: checkImage(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            tvshowDetails.name,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: <Widget>[
                      InfoBoxWidget(
                          typeInfo: 0, value: tvshowDetails.numberOfSeasons),
                      InfoBoxWidget(
                          typeInfo: 1, value: tvshowDetails.numberOfEpisodes),
                      InfoBoxWidget(
                          typeInfo: 2,
                          value: tvshowDetails.episodeRunTime.first)
                    ],
                  ),
                ),
                const Text('Sinopse',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(tvshowDetails.overview),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  ImageProvider checkImage() {
    if (tvshowDetails.posterPath == null) {
      return AssetImage(ImagePath.emptyTvShow);
    } else {
      return NetworkImage(BASE_IMAGE + tvshowDetails.posterPath);
    }
  }
}
