import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_randshow/core/viewmodels/widgets/favorite_list_model.dart';
import '../setup/test_helpers.dart';

void main() {
  group('FavoriteListViewModelTest -', () {
    setUp(() => registerServices());
    group('loadFavs -', () {
      test('When constructed, listFavs should be null', () async {
        final DatabaseMock database = getAndRegisterDatabaseMock();
        final FavoriteListModel model = FavoriteListModel();

        await model.loadFavs();
        verify(database.queryList());
        expect(model.listFavs, null);
      });
      test('When has items, listFavs should be 10 Tv show details', () async {
        final DatabaseMock database =
            getAndRegisterDatabaseMock(hasItems: true);
        final FavoriteListModel model = FavoriteListModel();

        await model.loadFavs();
        verify(database.queryList());
        expect(
          model.listFavs,
          database.mockList,
        );
      });
    });
    group('deleteFav -', () {
      test('When has items, delete one item from listFavs', () async {
        const int deletedItem = 1;
        final DatabaseMock database =
            getAndRegisterDatabaseMock(hasItems: true, deleteItem: deletedItem);
        final FavoriteListModel model = FavoriteListModel();

        await model.loadFavs();
        verify(database.queryList());
        model.deleteFav(deletedItem);
        verifyNever(database.delete(deletedItem));
        expect(
          model.listFavs,
          database.mockList,
        );
      });
    });
  });
}
