import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationNotifier<T, K> extends FamilyAsyncNotifier<List<T>, K> {
  PaginationNotifier({
    required this.getPageFunction,
    required this.sizePage,
    this.initialPage = 1,
    this.debounceNextPage = 1000,
  });

  /// Function that fetch each page.
  /// Should be return a future with list of items
  ///
  /// [page] is the actual page
  ///
  /// [input] is a filter with generic type `K`
  final Future<List<T>> Function(int page, K input) getPageFunction;

  /// Max number of items on each page
  final int sizePage;

  /// Number of page to start fetch items
  final int initialPage;

  /// Time allow to fetch next page again
  ///
  /// In milliseconds, by default `1000`
  final int debounceNextPage;

  @override
  FutureOr<List<T>> build(K arg) {
    page = initialPage;
    return [];
  }

  Timer _timer = Timer(Duration.zero, () {});

  int page = 1;
  bool noMoreItems = false;

  /// Update [state] with items of first page
  Future<void> firstPage() async {
    if (state.hasValue && state.requireValue.isEmpty) {
      state = AsyncValue<List<T>>.loading();
      state = await AsyncValue.guard(() async {
        final List<T> result = await getPageFunction(initialPage, arg);
        return _updateData(result);
      });
    }
  }

  /// Update [state] with items of next page
  Future<void> nextPage() async {
    if (_timer.isActive && state.requireValue.isNotEmpty) {
      return;
    }
    _timer = Timer(Duration(milliseconds: debounceNextPage), () {});

    if (noMoreItems) return;

    state = AsyncValue<List<T>>.loading();
    state = await AsyncValue.guard(
      () async {
        final result = await getPageFunction(page, arg);
        return _updateData(result);
      },
    );
  }

  List<T> _updateData(List<T> result) {
    noMoreItems = result.length < sizePage;
    page++;

    return result.isEmpty
        ? state.requireValue
        : [...state.requireValue, ...result];
  }
}
