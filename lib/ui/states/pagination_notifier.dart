import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationNotifier<T, K>
    extends AutoDisposeFamilyAsyncNotifier<List<T>, K> {
  /// Function that fetch each page.
  /// Should be return a future with list of items
  ///
  /// [_page] is the actual page
  ///
  /// [input] is a filter with generic type `K`.
  final Future<List<T>> Function(int page, K input) getPageFunction;

  /// Max number of items on each page.
  final int sizePage;

  /// Number of page to start fetch items.
  final int initialPage;

  /// Time allow to fetch next page again
  ///
  /// In milliseconds, by default `1000`.
  final int debounceNextPage;

  int _page = 1;
  bool _noMoreItems = false;
  Timer _timer = Timer(Duration.zero, () => {});

  bool get noMoreItems => _noMoreItems;

  PaginationNotifier({
    required this.getPageFunction,
    required this.sizePage,
    this.initialPage = 1,
    this.debounceNextPage = 1000,
  });

  @override
  FutureOr<List<T>> build(K arg) {
    _page = initialPage;

    return [];
  }

  /// Update [state] with items of first page.
  Future<void> firstPage() async {
    if (state.hasValue && state.requireValue.isEmpty) {
      state = AsyncValue<List<T>>.loading();
      state = await AsyncValue.guard(() async {
        final List<T> result = await getPageFunction(initialPage, arg);

        return _updateData(result);
      });
    }
  }

  /// Update [state] with items of next page.
  Future<void> nextPage() async {
    if (_timer.isActive && state.requireValue.isNotEmpty) {
      return;
    }
    _timer = Timer(Duration(milliseconds: debounceNextPage), () => {});

    if (_noMoreItems) return;

    state = AsyncValue<List<T>>.loading();
    state = await AsyncValue.guard(() async {
      final result = await getPageFunction(_page, arg);

      return _updateData(result);
    });
  }

  List<T> _updateData(List<T> result) {
    _noMoreItems = result.length < sizePage;
    _page++;

    return result.isEmpty
        ? state.requireValue
        : [...state.requireValue, ...result];
  }
}
