import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/ui/features/random/random_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/streaming_button.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.idTv});
  final int idTv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                translate('app.result.title'),
                key: const Key('app.result.title'),
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
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
                          bottom: 24.0,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
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
                                      data: (tvshowResult) => _TvshowResultInfo(
                                        tvshowResult: tvshowResult,
                                        streamings: ref
                                            .read(
                                              randomTvshowProvider(idTv)
                                                  .notifier,
                                            )
                                            .tvshow
                                            .streamings,
                                      ),
                                      error: (error, stackTrace) =>
                                          const ErrorMessage(
                                        keyText: 'app.result.error_load',
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const HomeButton(text: 'app.result.button_fav'),
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
  const _TvshowResultInfo({
    required this.tvshowResult,
    this.streamings = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          tvshowResult.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InfoBox(
                typeInfo: 3,
                value: tvshowResult.randomSeason,
              ),
              InfoBox(
                typeInfo: 4,
                value: tvshowResult.randomEpisode,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tvshowResult.episodeName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Flexible(
          flex: 3,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              tvshowResult.episodeDescription,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (streamings.isNotEmpty) ...[
          Text(
            translate('app.result.streaming_title'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 8,
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
          Text(
            translate(
              'app.result.no_streaming_title',
            ),
            style: Theme.of(context).textTheme.titleMedium,
          ),
      ],
    );
  }
}
