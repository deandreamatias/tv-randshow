import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/core/tvshow/domain/models/tvshow_result.dart';
import 'package:tv_randshow/ui/features/random/widgets/streaming_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/info_box.dart';
import 'package:tv_randshow/ui/widgets/media_header.dart';
import 'package:tv_randshow/ui/widgets/text_title_medium.dart';

class TvshowEpisodeInfoResult extends StatelessWidget {
  final TvshowResult result;
  const TvshowEpisodeInfoResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: MediaHeader(
            title: result.name,
            imagePath: result.image,
            child: result.streamings.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: result.streamings
                          .map(
                            (streaming) => Row(
                              children: [
                                StreamingButton(streamingDetail: streaming),
                                const SizedBox(width: Styles.small),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  )
                : TextTitleMedium(
                    context.tr('app.result.episode.no_streaming_title'),
                  ),
          ),
        ),
        Flexible(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InfoBox(typeInfo: InfoTypeBox.season, value: result.randomSeason),
              InfoBox(
                typeInfo: InfoTypeBox.episode,
                value: result.randomEpisode,
              ),
            ],
          ),
        ),
        const SizedBox(height: Styles.small),
        TextTitleMedium(result.episodeName),
        const SizedBox(height: Styles.small),
        Flexible(
          flex: 6,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(result.episodeDescription),
          ),
        ),
      ],
    );
  }
}
