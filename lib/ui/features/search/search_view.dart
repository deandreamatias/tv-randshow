import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/ui/features/search/search_state.dart';
import 'package:tv_randshow/ui/features/search/widgets/search_widget.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/error_message.dart';
import 'package:tv_randshow/ui/widgets/loaders/loader.dart';
import 'package:unicons/unicons.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.2;
      if (maxScroll - currentScroll <= delta) {
        ref
            .read(paginationProvider(ref.watch(searchProvider)).notifier)
            .nextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      restorationId: 'app.search.list',
      slivers: [
        const SliverToBoxAdapter(child: _SearchField()),
        _SearchResult(text: ref.watch(searchProvider)),
        SliverPadding(
          padding: const EdgeInsets.all(Styles.standard),
          sliver: SliverToBoxAdapter(
            child: _PaginationStatus(text: ref.watch(searchProvider)),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  void _onChanged(String text, WidgetRef ref) {
    if (text.isNotEmpty) {
      ref
          .watch(searchProvider.notifier)
          .searchAutomatic(
            text,
            () =>
                ref
                    .watch(
                      paginationProvider(ref.watch(searchProvider)).notifier,
                    )
                    .firstPage(),
          );
    }
  }

  void _onSubmitted(String text, WidgetRef ref) {
    if (text.isNotEmpty) {
      ref.watch(searchProvider.notifier).update(text);
      ref
          .watch(paginationProvider(ref.watch(searchProvider)).notifier)
          .firstPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.standard),
      child: Consumer(
        builder: (context, ref, child) {
          return TextField(
            key: const Key('app.search.search_bar'),
            textInputAction: TextInputAction.search,
            onSubmitted: (String text) {
              _onSubmitted(text, ref);
            },
            onChanged: (String text) {
              _onChanged(text, ref);
            },
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: translate('app.search.search_bar'),
              prefixIcon: const Icon(UniconsLine.search),
            ),
          );
        },
      ),
    );
  }
}

class _PaginationStatus extends ConsumerWidget {
  final String text;
  const _PaginationStatus({this.text = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginationProvider(text));

    return state.when(
      error:
          (error, stackTrace) =>
              ErrorMessage(keyText: 'app.search.error_message', error: error),
      loading:
          () =>
              state.hasValue && state.requireValue.isNotEmpty
                  ? const Loader()
                  : const SizedBox.shrink(),
      data: (items) {
        final noMoreItems =
            ref.read(paginationProvider(text).notifier).noMoreItems;

        return noMoreItems && state.requireValue.isNotEmpty
            ? Text(
              translate('app.search.no_more_items'),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            )
            : items.isNotEmpty
            ? Center(
              child: TextButton.icon(
                onPressed: () {
                  ref.read(paginationProvider(text).notifier).nextPage();
                },
                icon: const Icon(UniconsLine.plus_circle),
                label: Text(translate('app.search.load_more_items')),
              ),
            )
            : const SizedBox.shrink();
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  final String text;
  const _SearchResult({required this.text});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(paginationProvider(text));

        return state.when(
          data: (items) {
            return items.isEmpty
                ? SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(Styles.standard),
                      child: Text(
                        translate(
                          text.isEmpty
                              ? 'app.search.init_message'
                              : 'app.search.empty_message',
                        ),
                        key: const Key('app.search.message'),
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
                : _GridBuilder(items: items);
          },
          loading: () {
            return state.hasValue && state.requireValue.isNotEmpty
                ? _GridBuilder(items: state.requireValue)
                : const SliverToBoxAdapter(child: Loader());
          },
          error:
              (error, stk) => SliverToBoxAdapter(
                child: ErrorMessage(
                  keyText: 'app.search.error_message',
                  error: error,
                ),
              ),
        );
      },
    );
  }
}

class _GridBuilder extends StatelessWidget {
  const _GridBuilder({required this.items});

  final List<Result> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.standard),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.8,
          mainAxisSpacing: Styles.standard,
          crossAxisSpacing: Styles.standard,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => SearchWidget(result: items[index]),
      ),
    );
  }
}
