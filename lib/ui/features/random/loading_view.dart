import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/random/random_tvshow_state.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.idTv});
  final int idTv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  translate('app.loading.title'),
                  key: const Key('app.loading.title'),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(randomTvshowProvider(idTv)).when(
                            data: (data) {
                              // TODO: navigate when load data
                              if (!ref
                                  .watch(randomTvshowProvider(idTv))
                                  .isRefreshing) {
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  () => Navigator.of(context)
                                      .pushReplacementNamed(
                                    RoutePaths.result,
                                    arguments: idTv,
                                  ),
                                );
                              }
                              return const FlareActor(
                                Assets.loading,
                                animation: 'Loading',
                              );
                            },
                            error: (error, stackTrace) => const ErrorMessage(
                              keyText: 'app.loading.general_error',
                            ),
                            loading: () => const FlareActor(
                              Assets.loading,
                              animation: 'Loading',
                            ),
                          );
                    },
                  ),
                ),
                const HomeButton(text: 'app.loading.button_fav')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
