import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/home/widgets/fav_widget.dart';
import 'package:tv_randshow/ui/states/export_tvshow_state.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';
import 'package:tv_randshow/ui/widgets/error_icon.dart';
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
        return ref.watch(favTvshowsProvider).when(
              data: (tvshows) => tvshows.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180.0,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemCount: tvshows.length,
                      itemBuilder: (BuildContext context, int index) =>
                          FavWidget(
                        key: Key(tvshows[index].id.toString()),
                        tvshowDetails: tvshows[index],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          translate('app.fav.empty_message'),
                          key: const Key('app.fav.empty_message'),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              error: (error, stackTrace) => const ErrorIcon(
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
            ? ref.watch(exportTvshowsProvider).when(
                  data: (success) => success
                      ? IconButton(
                          key: const Key('app.fav.save'),
                          tooltip: translate('app.fav.save'),
                          icon: Icon(
                            UniconsLine.file_export,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            ref.read(exportTvshowsProvider.notifier).export();
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
    );
  }
}
