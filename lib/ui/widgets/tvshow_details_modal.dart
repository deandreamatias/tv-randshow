import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/states/tvshows_provider.dart';

import 'package:tv_randshow/ui/viewmodels/widgets/details_model.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:tv_randshow/ui/widgets/random_button.dart';
import 'package:tv_randshow/ui/widgets/save_button.dart';

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
          constraints: const BoxConstraints(
            maxWidth: 500.0,
            maxHeight: 425.0,
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.vertical(
                top: Radius.circular(16),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: _TvshowInfoDetails(idTv: idTv),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final tvshowDetails =
                ref.watch(favTvshowsProvider.notifier).hasFav(idTv);
            return tvshowDetails && showRandom
                ? RandomButton(idTv: idTv)
                : SaveButton(id: idTv);
          },
        )
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
        final state = ref.watch(tvshowDetailsProvider(idTv));
        return state.when(
          data: (model) => Column(
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
                          url: model.posterPath,
                          name: model.name,
                          isModal: true,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            model.name,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.titleLarge,
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
                      value: model.numberOfSeasons,
                    ),
                    InfoBox(
                      typeInfo: 1,
                      value: model.numberOfEpisodes,
                    ),
                    InfoBox(
                      typeInfo: 2,
                      value: model.episodeRunTime.isNotEmpty
                          ? model.episodeRunTime.first
                          : 0,
                    )
                  ],
                ),
              ),
              Text(
                translate('app.modal.overview'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(model.overview),
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => ErrorMessage(
            keyText: 'app.modal.error_load',
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
      },
    );
  }
}
