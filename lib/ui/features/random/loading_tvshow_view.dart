import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/random/random_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/loading_base_view.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/animation_random_loader.dart';

class LoadingTvshowView extends StatelessWidget {
  const LoadingTvshowView({super.key, required this.idTv});
  final int idTv;

  @override
  Widget build(BuildContext context) {
    return LoadingBaseView(
      titleKey: 'app.loading.title',
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(randomTvshowProvider(idTv)).when(
                data: (data) {
                  // TODO: navigate when load data.
                  if (!ref.watch(randomTvshowProvider(idTv)).isRefreshing) {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => Navigator.of(context).pushReplacementNamed(
                        RoutePaths.result,
                        arguments: idTv,
                      ),
                    );
                  }

                  return const AnimationRandomLoader();
                },
                error: (error, stackTrace) => ErrorMessage(
                  keyText: 'app.loading.general_error',
                  error: error,
                ),
                loading: () => const AnimationRandomLoader(),
              );
        },
      ),
    );
  }
}
