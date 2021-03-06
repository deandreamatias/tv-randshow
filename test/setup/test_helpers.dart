import 'package:mockito/mockito.dart';
import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/hive_database_service.dart';

class DatabaseMock extends Mock implements HiveDatabaseService {
  final List<TvshowDetails> mockList =
      List<TvshowDetails>.generate(10, (int index) => TvshowDetails(id: index));
}

class ApiMock extends Mock implements ApiService {}

DatabaseMock getAndRegisterDatabaseMock(
    {bool hasItems = false, int deleteItem = 1}) {
  _removeRegistrationIfExists<HiveDatabaseService>();
  final DatabaseMock database = DatabaseMock();
  when(database.getTvshows()).thenAnswer((Invocation realInvocation) async {
    await Future<Duration>.delayed(const Duration(milliseconds: 500));
    return hasItems ? database.mockList : null;
  });
  when(database.deleteTvshow(deleteItem))
      .thenAnswer((Invocation realInvocation) {
    database.mockList.removeAt(deleteItem);
    return;
  });
  locator.registerSingleton<HiveDatabaseService>(database);
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
  locator.unregister<HiveDatabaseService>();
  locator.unregister<ApiService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
