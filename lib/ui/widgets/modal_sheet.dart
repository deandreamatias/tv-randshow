import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import 'package:tv_randshow/ui/viewmodels/widgets/details_model.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/random_button.dart';
import 'package:tv_randshow/ui/widgets/save_button.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({super.key, required this.idTv, this.inDatabase = false});
  final int idTv;
  final bool inDatabase;
  // TODO(deandreamatias): Persist state of button on search and fav widgets

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsModel>.reactive(
      viewModelBuilder: () => DetailsModel(),
      onViewModelReady: (DetailsModel model) => model.getDetails(
        idTv,
        LocalizedApp.of(context).delegate.currentLocale.languageCode.toString(),
      ),
      builder: (BuildContext context, DetailsModel model, Widget? child) =>
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
                color: Theme.of(context).colorScheme.background,
              ),
              child: model.isBusy
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
                                  child: ImageBuilder(
                                    url: model.tvshowDetails!.posterPath,
                                    name: model.tvshowDetails!.name,
                                    isModal: true,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      model.tvshowDetails!.name,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
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
                                value: model.tvshowDetails!.numberOfSeasons,
                              ),
                              InfoBox(
                                typeInfo: 1,
                                value: model.tvshowDetails!.numberOfEpisodes,
                              ),
                              InfoBox(
                                typeInfo: 2,
                                value: model.tvshowDetails!.episodeRunTime
                                        .isNotEmpty
                                    ? model.tvshowDetails!.episodeRunTime.first
                                    : 0,
                              )
                            ],
                          ),
                        ),
                        Text(
                          translate('app.modal.overview'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          flex: 6,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(model.tvshowDetails!.overview),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (inDatabase)
            model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : RandomButton(tvshowDetails: model.tvshowDetails!)
          else
            SaveButton(id: idTv),
        ],
      ),
    );
  }
}
