import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/states/random_tvshows_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/random_again_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/result_base_view.dart';
import 'package:tv_randshow/ui/features/random/widgets/tvshow_episode_info_result.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';

class ResultTvshowsView extends StatelessWidget {
  const ResultTvshowsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultBaseView(
      actionButton: Consumer(
        builder: (context, ref, child) {
          return RandomAgainButton(
            labelKey: 'app.result.tvshow.button_random',
            onPressed: () => ref.invalidate(randomTvshowsProvider),
          );
        },
      ),
      titleKey: 'app.result.tvshow.title',
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(randomTvshowsProvider).when(
                data: (result) => TvshowEpisodeInfoResult(result: result),
                error: (error, stackTrace) => ErrorMessage(
                  keyText: 'app.result.tvshow.error_load',
                  error: error,
                ),
                loading: () => const Loader(),
              );
        },
      ),
    );
  }
}
