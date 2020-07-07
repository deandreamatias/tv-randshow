import 'package:mockito/mockito.dart';
import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/database_service.dart';

class DatabaseMock extends Mock implements DatabaseService {
  final List<TvshowDetails> mockList = List<TvshowDetails>.generate(
      10, (int index) => TvshowDetails(rowId: index));
}

class ApiMock extends Mock implements ApiService {}

DatabaseMock getAndRegisterDatabaseMock(
    {bool hasItems = false, int deleteItem = 1}) {
  _removeRegistrationIfExists<DatabaseService>();
  final DatabaseMock database = DatabaseMock();
  when(database.queryList()).thenAnswer((Invocation realInvocation) async {
    await Future<Duration>.delayed(const Duration(milliseconds: 500));
    return hasItems ? database.mockList : null;
  });
  when(database.delete(deleteItem)).thenAnswer((Invocation realInvocation) {
    database.mockList.removeAt(deleteItem);
    return;
  });
  locator.registerSingleton<DatabaseService>(database);
  return database;
}

ApiMock getAndRegisterApiMock() {
  _removeRegistrationIfExists<ApiService>();
  final ApiMock api = ApiMock();
  locator.registerSingleton<ApiService>(api);
  return api;
}

void registerServices() {
  getAndRegisterDatabaseMock();
  getAndRegisterApiMock();
  FlavorConfig(flavor: Flavor.DEV, values: FlavorValues.fromJson(environment));
}

void unregisterServices() {
  locator.unregister<DatabaseService>();
  locator.unregister<ApiService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
