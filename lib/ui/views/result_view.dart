import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/models/tvshow_result.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/views/loading_view.dart';
import 'package:tv_randshow/ui/widgets/home_button.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/streaming_button.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.tvshowResult});
  final TvshowResult tvshowResult;
  @override
  Widget build(BuildContext context) {
    final List<StreamingDetail> streamings =
        tvshowResult.tvshowDetails.streamings;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  translate('app.result.title'),
                  key: const Key('app.result.title'),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  tvshowResult.tvshowDetails.name,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Flexible(
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child:
                                        Text(tvshowResult.episodeDescription),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (streamings.isNotEmpty) ...[
                                  Text(
                                    translate('app.result.streaming_title'),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                    translate('app.result.no_streaming_title'),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton.icon(
                            icon: const Icon(CustomIcons.diceMultiple),
                            label: Text(
                              translate('app.result.button_random'),
                              key: const Key('app.result.button_random'),
                            ),
                            onPressed: () => Navigator.pushNamed<LoadingView>(
                              context,
                              RoutePaths.loading,
                              arguments: tvshowResult.tvshowDetails,
                            ),
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
