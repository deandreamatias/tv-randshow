import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/details_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
import 'cached_image.dart';
import 'info_box.dart';
import 'random_button.dart';
import 'save_button.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({this.idTv, this.inDatabase});
  final int idTv;
  final bool inDatabase;
  // TODO(deandreamatias): Persist state of button on search and fav widgets

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DetailsModel>(
      model: DetailsModel(
        apiService: Provider.of(context),
        secureStorageService: Provider.of(context),
      ),
      onModelReady: (DetailsModel model) => model.getDetails(
        idTv,
        LocalizedApp.of(context).delegate.currentLocale.languageCode.toString(),
      ),
      builder: (BuildContext context, DetailsModel model, Widget child) =>
          Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: DEFAULT_INSESTS,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(16.0),
              ),
              color: StyleColor.WHITE,
            ),
            child: model.busy
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                                child: CachedImage(
                                    url: model.tvshowDetails?.posterPath,
                                    isModal: true),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    model.tvshowDetails?.name,
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
                            InfoBox(
                              typeInfo: 0,
                              value:
                                  model.tvshowDetails.numberOfSeasons ?? '--',
                            ),
                            InfoBox(
                              typeInfo: 1,
                              value:
                                  model.tvshowDetails.numberOfEpisodes ?? '--',
                            ),
                            InfoBox(
                              typeInfo: 2,
                              value:
                                  model.tvshowDetails.episodeRunTime.isNotEmpty
                                      ? model.tvshowDetails.episodeRunTime.first
                                      : 0,
                            )
                          ],
                        ),
                      ),
                      Text(translate('app.modal.overview'),
                          style: StyleText.MESSAGES),
                      const SizedBox(height: 8.0),
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(model.tvshowDetails.overview),
                        ),
                      ),
                    ],
                  ),
          ),
          if (inDatabase)
            RandomButton(tvshowDetails: model.tvshowDetails)
          else
            SaveButton(id: idTv),
        ],
      ),
    );
  }
}
