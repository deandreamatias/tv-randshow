import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/states/random_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/random_again_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/result_base_view.dart';
import 'package:tv_randshow/ui/features/random/widgets/tvshow_episode_info_result.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';

class ResultTvshowView extends StatelessWidget {
  const ResultTvshowView({super.key, required this.idTv});
  final int idTv;
  @override
  Widget build(BuildContext context) {
    return ResultBaseView(
      actionButton: Consumer(
        builder: (context, ref, child) {
          return RandomAgainButton(
            labelKey: 'app.result.episode.button_random',
            onPressed: () => ref.invalidate(randomTvshowProvider(idTv)),
          );
        },
      ),
      titleKey: 'app.result.episode.title',
      child: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(randomTvshowProvider(idTv))
              .when(
                data: (result) => TvshowEpisodeInfoResult(result: result),
                error: (error, stackTrace) => ErrorMessage(
                  keyText: 'app.result.episode.error_load',
                  error: error,
                ),
                loading: () => const Loader(),
              );
        },
      ),
    );
  }
}
