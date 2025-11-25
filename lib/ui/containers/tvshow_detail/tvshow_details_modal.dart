import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/containers/tvshow_detail/tvshow_details_state.dart';
import 'package:tv_randshow/ui/features/home/widgets/random_button.dart';
import 'package:tv_randshow/ui/features/search/widgets/save_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:tv_randshow/ui/widgets/media_header.dart';
import 'package:tv_randshow/ui/widgets/text_title_medium.dart';

class TvshowDetailsModal extends StatelessWidget {
  const TvshowDetailsModal({
    super.key,
    required this.idTv,
    this.showRandom = true,
  });
  final int idTv;
  final bool showRandom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 425),
          child: Container(
            margin: const EdgeInsets.only(top: Styles.large),
            padding: const EdgeInsets.all(Styles.standard),
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.vertical(
                top: Radius.circular(Styles.standard),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: _TvshowInfoDetails(idTv: idTv),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final tvshowDetails = ref
                .watch(favTvshowsProvider.notifier)
                .hasFav(idTv);

            return tvshowDetails && showRandom
                ? RandomButton(idTv: idTv)
                : SaveButton(tvId: idTv);
          },
        ),
      ],
    );
  }
}

class _TvshowInfoDetails extends StatelessWidget {
  const _TvshowInfoDetails({required this.idTv});

  final int idTv;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref
            .watch(tvshowDetailsProvider(idTv))
            .when(
              data: (model) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: Styles.small),
                      child: MediaHeader(
                        imagePath: model.posterPath,
                        title: model.name,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InfoBox(
                          typeInfo: InfoTypeBox.seasons,
                          value: model.numberOfSeasons,
                        ),
                        InfoBox(
                          typeInfo: InfoTypeBox.episodes,
                          value: model.numberOfEpisodes,
                        ),
                        InfoBox(
                          typeInfo: InfoTypeBox.duration,
                          value: model.episodeRunTime.isNotEmpty
                              ? model.episodeRunTime.first
                              : 0,
                        ),
                      ],
                    ),
                  ),
                  TextTitleMedium(context.tr('app.modal.overview')),
                  const SizedBox(height: Styles.small),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(model.overview),
                    ),
                  ),
                ],
              ),
              error: (error, stackTrace) =>
                  ErrorMessage(keyText: 'app.modal.error_load', error: error),
              loading: () => const Loader(),
            );
      },
    );
  }
}
