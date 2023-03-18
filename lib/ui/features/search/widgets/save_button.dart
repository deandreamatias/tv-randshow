import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/states/tvshow_state.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:unicons/unicons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.tvId});
  final int tvId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final watcher = ref.watch(tvshowOnFavsProvider(tvId));

        const loader = SizedBox.square(
          dimension: Styles.medium,
          child: Loader(),
        );

        return IgnorePointer(
          ignoring: watcher.isLoading,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: watcher.hasValue && watcher.requireValue
                ? ElevatedButton.icon(
                    key: const ValueKey<String>('delete'),
                    icon: const Icon(UniconsLine.times),
                    label: watcher.isLoading
                        ? loader
                        : Text(
                            translate('app.search.button_delete'),
                            key: Key('app.search.button_delete.$tvId'),
                          ),
                    onPressed: () => ref
                        .read(tvshowOnFavsProvider(tvId).notifier)
                        .deleteFromFavs(),
                  )
                : ElevatedButton.icon(
                    key: const ValueKey<String>('add'),
                    icon: const Icon(UniconsLine.favorite),
                    label: watcher.isLoading
                        ? loader
                        : Text(
                            translate('app.search.button_fav'),
                            key: Key('app.search.button_fav.$tvId'),
                          ),
                    onPressed: () => ref
                        .read(tvshowOnFavsProvider(tvId).notifier)
                        .addToFavs(),
                  ),
          ),
        );
      },
    );
  }
}
