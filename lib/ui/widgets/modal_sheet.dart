import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/details_model.dart';
import '../base_widget.dart';
import 'image_builder.dart';
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
      ),
      onModelReady: (DetailsModel model) => model.getDetails(
        idTv,
        LocalizedApp.of(context).delegate.currentLocale.languageCode.toString(),
      ),
      builder: (BuildContext context, DetailsModel model, Widget child) =>
          Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500.0,
              maxHeight: 425.0,
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.vertical(
                  top: Radius.circular(16.0),
                ),
                color: Theme.of(context).backgroundColor,
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
                                  child: ImageBuilder(
                                    url: model.tvshowDetails?.posterPath,
                                    name: model.tvshowDetails?.name,
                                    isModal: true,
                                  ),
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
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InfoBox(
                                typeInfo: 0,
                                value:
                                    model.tvshowDetails.numberOfSeasons ?? '--',
                              ),
                              InfoBox(
                                typeInfo: 1,
                                value: model.tvshowDetails.numberOfEpisodes ??
                                    '--',
                              ),
                              InfoBox(
                                typeInfo: 2,
                                value: model
                                        .tvshowDetails.episodeRunTime.isNotEmpty
                                    ? model.tvshowDetails.episodeRunTime.first
                                    : 0,
                              )
                            ],
                          ),
                        ),
                        Text(
                          translate('app.modal.overview'),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
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
          ),
          if (inDatabase || kIsWeb)
            RandomButton(tvshowDetails: model.tvshowDetails)
          else
            SaveButton(id: idTv),
        ],
      ),
    );
  }
}
