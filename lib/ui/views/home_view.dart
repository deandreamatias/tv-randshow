import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/states/tvshows_provider.dart';
import 'package:tv_randshow/ui/viewmodels/views/info_view_model.dart';
import 'package:tv_randshow/ui/widgets/favorite_list.dart';
import 'package:tv_randshow/ui/widgets/icons/error_icon.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  translate('app.fav.title'),
                  key: const Key('app.fav.title'),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final tvshows = ref.watch(favTvshowsProvider);
                  return tvshows.hasValue && tvshows.requireValue.isNotEmpty
                      ? ref.watch(exportTvshowsProvider).when(
                            data: (success) => success
                                ? IconButton(
                                    key: const Key('app.fav.save'),
                                    tooltip: translate('app.fav.save'),
                                    icon: Icon(
                                      UniconsLine.file_export,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    onPressed: () async {
                                      ref
                                          .read(exportTvshowsProvider.notifier)
                                          .export();
                                    },
                                  )
                                : const ErrorIcon(
                                    keyText: 'app.info.export_error',
                                  ),
                            error: (error, stackTrace) => const ErrorIcon(
                              keyText: 'app.info.export_error',
                            ),
                            loading: () => const Loader(),
                          )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        const Expanded(child: FavoriteList()),
      ],
    );
  }
}
