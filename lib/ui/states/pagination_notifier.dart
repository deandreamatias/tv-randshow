import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationNotifier<T, K> extends FamilyAsyncNotifier<List<T>, K> {
  PaginationNotifier({
    required this.getNextPage,
    required this.itemsByPage,
    this.initialPage = 1,
  });

  @override
  FutureOr<List<T>> build(K arg) {
    page = initialPage;
    return [];
  }

  final Future<List<T>> Function(int page, K input) getNextPage;
  final int itemsByPage;
  final int initialPage;

  Timer _timer = Timer(Duration.zero, () {});

  int page = 1;
  bool noMoreItems = false;

  Future<void> firstPage() async {
    if (state.hasValue && state.requireValue.isEmpty) {
      state = AsyncValue<List<T>>.loading();

      state = await AsyncValue.guard(() async {
        final List<T> result = await getNextPage(initialPage, arg);
        return _updateData(result);
      });
    }
  }

  Future<void> nextPage() async {
    if (_timer.isActive && state.requireValue.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});

    if (noMoreItems) return;

    state = AsyncValue<List<T>>.loading();
    state = await AsyncValue.guard(
      () async {
        await Future.delayed(const Duration(seconds: 1));
        final result = await getNextPage(page, arg);
        return _updateData(result);
      },
    );
  }

  List<T> _updateData(List<T> result) {
    noMoreItems = result.length < itemsByPage;
    page++;

    return result.isEmpty
        ? state.requireValue
        : [...state.requireValue, ...result];
  }
}
