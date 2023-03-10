import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/ui/features/random/random_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/streaming_button.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';
import 'package:tv_randshow/ui/widgets/text_title_medium.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.idTv});
  final int idTv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: Column(
            children: <Widget>[
              TextTitleLarge(
                translate('app.result.title'),
                key: const Key('app.result.title'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Styles.standard),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          right: 0.0,
                          left: 0.0,
                          top: 0.0,
                          bottom: Styles.large,
                          child: Container(
                            padding: const EdgeInsets.all(Styles.standard),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Styles.small),
                              ),
                              border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            child: Consumer(
                              builder: (context, ref, child) {
                                return ref
                                    .watch(randomTvshowProvider(idTv))
                                    .when(
                                      data: (tvshowResult) {
                                        final tvshow = ref
                                            .read(
                                              randomTvshowProvider(idTv)
                                                  .notifier,
                                            )
                                            .tvshow;

                                        return _TvshowResultInfo(
                                          tvshowResult: tvshowResult,
                                          streamings: tvshow.streamings,
                                          tvshowName: tvshow.name,
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          ErrorMessage(
                                        keyText: 'app.result.error_load',
                                        error: error.toString(),
                                      ),
                                      loading: () => const Loader(),
                                    );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Consumer(
                            builder: (context, ref, child) {
                              return ElevatedButton.icon(
                                icon: const Icon(CustomIcons.diceMultiple),
                                label: Text(
                                  translate('app.result.button_random'),
                                  key: const Key('app.result.button_random'),
                                ),
                                onPressed: () =>
                                    ref.invalidate(randomTvshowProvider(idTv)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const HomeButton(keyText: 'app.result.button_fav'),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvshowResultInfo extends StatelessWidget {
  final TvshowResult tvshowResult;
  final List<StreamingDetail> streamings;
  final String tvshowName;
  const _TvshowResultInfo({
    required this.tvshowResult,
    this.streamings = const [],
    this.tvshowName = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextTitleLarge(tvshowName),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InfoBox(
                typeInfo: InfoTypeBox.season,
                value: tvshowResult.randomSeason,
              ),
              InfoBox(
                typeInfo: InfoTypeBox.episode,
                value: tvshowResult.randomEpisode,
              ),
            ],
          ),
        ),
        const SizedBox(height: Styles.small),
        TextTitleMedium(tvshowResult.episodeName),
        const SizedBox(height: Styles.small),
        Flexible(
          flex: 3,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(tvshowResult.episodeDescription),
          ),
        ),
        const SizedBox(height: Styles.small),
        if (streamings.isNotEmpty) ...[
          TextTitleMedium(translate('app.result.streaming_title')),
          const SizedBox(height: Styles.small),
          Wrap(
            spacing: Styles.small,
            runSpacing: Styles.small,
            children: streamings
                .map(
                  (streaming) => StreamingButton(
                    streamingDetail: streaming,
                  ),
                )
                .toList(),
          ),
        ],
        if (streamings.isEmpty)
          TextTitleMedium(translate('app.result.no_streaming_title')),
      ],
    );
  }
}
