import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/states/tvshow_provider.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:unicons/unicons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final watcher = ref.watch(tvshowOnFavsProvider(id));
        return IgnorePointer(
          ignoring: watcher.isLoading,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: watcher.hasValue && watcher.requireValue
                ? ElevatedButton.icon(
                    key: const ValueKey<String>('delete'),
                    icon: const Icon(UniconsLine.times),
                    label: watcher.isLoading
                        ? const SizedBox.square(dimension: 12, child: Loader())
                        : Text(
                            translate('app.search.button_delete'),
                            key: Key('app.search.button_delete.$id'),
                          ),
                    onPressed: () => ref
                        .read(tvshowOnFavsProvider(id).notifier)
                        .deleteFromFavs(),
                  )
                : ElevatedButton.icon(
                    key: const ValueKey<String>('add'),
                    icon: const Icon(UniconsLine.favorite),
                    label: watcher.isLoading
                        ? const SizedBox.square(dimension: 12, child: Loader())
                        : Text(
                            translate('app.search.button_fav'),
                            key: Key('app.search.button_fav.$id'),
                          ),
                    onPressed: () =>
                        ref.read(tvshowOnFavsProvider(id).notifier).addToFavs(),
                  ),
          ),
        );
      },
    );
  }
}
