import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/states/random_trending_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/random_again_button.dart';
import 'package:tv_randshow/ui/features/random/widgets/result_base_view.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:tv_randshow/ui/widgets/media_header.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';
import 'package:unicons/unicons.dart';

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
      trailing: IconButton(
        onPressed: () {
          // Do not use return dialog value.
          // ignore: avoid-ignoring-return-values
          showDialog(
            context: context,
            builder: (context) => const _TrendingInfoDialog(),
          );
        },
        icon: Icon(
          UniconsLine.info_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      titleKey: 'app.result.trending_tvshow.title',
      child: const _TvshowResultInfo(),
    );
  }
}

class _TrendingInfoDialog extends StatelessWidget {
  const _TrendingInfoDialog();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: TextTitleLarge(
        context.tr('app.result.trending_tvshow.dialog_title'),
      ),
      contentPadding: const EdgeInsets.all(Styles.large),
      children: [
        Text(context.tr('app.result.trending_tvshow.dialog_body_1')),
        const SizedBox(height: Styles.medium),
        Text(context.tr('app.result.trending_tvshow.dialog_body_2')),
        const SizedBox(height: Styles.medium),
        OutlinedButton(
          key: const Key('app.result.trending_tvshow.dialog_button'),
          child: Text(context.tr('app.result.trending_tvshow.dialog_button')),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _TvshowResultInfo extends StatelessWidget {
  const _TvshowResultInfo();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref
            .watch(randomTrendingTvshowProvider)
            .when(
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
                    Flexible(flex: 3, child: Text(result.overview)),
                  ],
                );
              },
              error:
                  (error, stackTrace) => ErrorMessage(
                    keyText: 'app.result.trending_tvshow.error_load',
                    error: error,
                  ),
              loading: () => const Loader(),
            );
      },
    );
  }
}
