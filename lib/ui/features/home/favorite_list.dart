import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/home/widgets/fav_widget.dart';
import 'package:tv_randshow/ui/states/tvshows_state.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:unicons/unicons.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

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
              error: (error, stackTrace) => Icon(
                UniconsLine.exclamation_octagon,
                color: Theme.of(context).colorScheme.error,
              ),
              loading: () => const Loader(key: Key('app.fav.loading')),
            );
      },
    );
  }
}
