import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/ui/viewmodels/views/search_view_model.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:tv_randshow/ui/widgets/search_widget.dart';
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
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref
            .read(paginationProvider(ref.watch(searchProvider)).notifier)
            .nextPage();
      }
    });
    super.initState();
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
          padding: const EdgeInsets.all(16),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer(
        builder: (context, ref, child) {
          return TextField(
            key: const Key('app.search.search_bar'),
            textInputAction: TextInputAction.search,
            onSubmitted: (String text) {
              if (text.isNotEmpty) {
                ref.watch(searchProvider.notifier).update(text);
                ref
                    .read(
                      paginationProvider(ref.watch(searchProvider)).notifier,
                    )
                    .firstPage();
              }
            },
            onChanged: (String text) {
              if (text.isNotEmpty) {
                ref.watch(searchProvider.notifier).searchAutomatic(
                      text,
                      () => ref
                          .read(
                            paginationProvider(ref.watch(searchProvider))
                                .notifier,
                          )
                          .firstPage(),
                    );
              }
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
      error: (error, stackTrace) => _ErrorMessage(error: error.toString()),
      loading: () => state.hasValue && state.requireValue.isNotEmpty
          ? const Loader()
          : const SizedBox.shrink(),
      data: (items) {
        final noMoreItems =
            ref.read(paginationProvider(text).notifier).noMoreItems;
        return noMoreItems
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
                      label: Text(translate('app.search.no_more_items')),
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
                        padding: const EdgeInsets.all(16.0),
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
          error: (error, stk) =>
              SliverToBoxAdapter(child: _ErrorMessage(error: error.toString())),
        );
      },
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String error;
  const _ErrorMessage({this.error = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(UniconsLine.exclamation_octagon),
          const SizedBox(height: 16),
          Text(
            '${translate('app.search.error_message')}\n$error',
            key: const Key('app.search.error_message'),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _GridBuilder extends StatelessWidget {
  const _GridBuilder({required this.items});

  final List<Result> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.8,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => SearchWidget(result: items[index]),
      ),
    );
  }
}
