import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_randshow/ui/features/home/widgets/fav_widget.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/states/export_tvshow_state.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';
import 'package:tv_randshow/ui/widgets/error_icon.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: Row(
            children: [
              Expanded(
                child: TextTitleLarge(
                  context.tr('app.fav.title'),
                  key: const Key('app.fav.title'),
                  textAlign: TextAlign.center,
                ),
              ),
              const _ExportTvshowsButton(),
            ],
          ),
        ),
        const Expanded(child: _FavoriteList()),
      ],
    );
  }
}

class _FavoriteList extends StatelessWidget {
  const _FavoriteList();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref
            .watch(favTvshowsProvider)
            .when(
              data:
                  (tvshows) =>
                      tvshows.isNotEmpty
                          ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180.0,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: Styles.standard,
                                  mainAxisSpacing: Styles.standard,
                                ),
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(Styles.standard),
                            itemCount: tvshows.length,
                            itemBuilder:
                                (BuildContext context, int index) => FavWidget(
                                  key: Key(tvshows[index].id.toString()),
                                  tvshowDetails: tvshows[index],
                                ),
                          )
                          : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(Styles.standard),
                              child: Text(
                                context.tr('app.fav.empty_message'),
                                key: const Key('app.fav.empty_message'),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
              error:
                  (error, stackTrace) => ErrorMessage(
                    error: error,
                    keyText: 'app.fav.error_message',
                  ),
              loading: () => const Loader(key: Key('app.fav.loading')),
            );
      },
    );
  }
}

class _ExportTvshowsButton extends StatelessWidget {
  const _ExportTvshowsButton();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final tvshows = ref.watch(favTvshowsProvider);

        return tvshows.hasValue && tvshows.requireValue.isNotEmpty
            ? ref
                .watch(exportTvshowsProvider)
                .when(
                  data:
                      (success) =>
                          success
                              ? IconButton(
                                key: const Key('app.fav.save'),
                                tooltip: context.tr('app.fav.save'),
                                icon: Icon(
                                  UniconsLine.file_export,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  ref
                                      .read(exportTvshowsProvider.notifier)
                                      .export();
                                },
                              )
                              : const ErrorIcon(
                                keyText: 'app.info.export_error',
                              ),
                  error:
                      (error, stackTrace) =>
                          const ErrorIcon(keyText: 'app.info.export_error'),
                  loading: () => const Loader(),
                )
            : const SizedBox.shrink();
      },
    );
  }
}
