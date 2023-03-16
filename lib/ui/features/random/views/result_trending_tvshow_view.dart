import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/states/random_trending_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/random_again_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/result_base_view.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:tv_randshow/ui/widgets/media_header.dart';

class ResultTrendingTvshowView extends StatelessWidget {
  const ResultTrendingTvshowView({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultBaseView(
      actionButton: Consumer(
        builder: (context, ref, child) {
          return RandomAgainButton(
            labelKey: 'app.result.trending_tvshow.button_random',
            onPressed: () => ref.invalidate(randomTrendingTvshowProvider),
          );
        },
      ),
      titleKey: 'app.result.trending_tvshow.title',
      child: const _TvshowResultInfo(),
    );
  }
}

class _TvshowResultInfo extends StatelessWidget {
  const _TvshowResultInfo();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(randomTrendingTvshowProvider).when(
              data: (result) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: MediaHeader(
                        title: result.name,
                        imagePath: result.posterPath,
                      ),
                    ),
                    const SizedBox(height: Styles.small),
                    Flexible(
                      flex: 3,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Text(result.overview),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => ErrorMessage(
                keyText: 'app.result.trending_tvshow.error_load',
                error: error,
              ),
              loading: () => const Loader(),
            );
      },
    );
  }
}
