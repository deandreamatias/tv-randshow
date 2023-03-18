import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/states/random_tvshows_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/loading_base_view.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/animation_random_loader.dart';

class LoadingTvshowsView extends StatelessWidget {
  const LoadingTvshowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingBaseView(
      titleKey: 'app.loading.tvshow.title',
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(randomTvshowsProvider).when(
                data: (data) {
                  // TODO: navigate when load data.
                  if (!ref.watch(randomTvshowsProvider).isRefreshing) {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => Navigator.of(context).pushReplacementNamed(
                        RoutePaths.resultTvshows,
                      ),
                    );
                  }

                  return const AnimationRandomLoader();
                },
                error: (error, stackTrace) => ErrorMessage(
                  keyText: 'app.loading.tvshow.general_error',
                  error: error,
                ),
                loading: () => const AnimationRandomLoader(),
              );
        },
      ),
    );
  }
}
