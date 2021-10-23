import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_randshow/config/env.dart';
import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/locator.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/services/api_service.dart';
import 'package:tv_randshow/core/services/databases/i_database_service.dart';

class DatabaseMock extends Mock implements IDatabaseService {
  final List<TvshowDetails> mockList = List<TvshowDetails>.generate(
      10,
      (int index) => TvshowDetails(
            id: index,
            name: faker.lorem.sentence(),
            numberOfEpisodes: faker.randomGenerator.integer(999),
            numberOfSeasons: faker.randomGenerator.integer(50),
          ));
}

class ApiMock extends Mock implements ApiService {}

DatabaseMock getAndRegisterDatabaseMock(
    {bool hasItems = false, int deleteItem = 1}) {
  _removeRegistrationIfExists<IDatabaseService>();
  final DatabaseMock database = DatabaseMock();
  when(database.getTvshows()).thenAnswer((Invocation realInvocation) async {
    await Future<Duration>.delayed(const Duration(milliseconds: 500));
    return hasItems ? database.mockList : [];
  });
  when(database.deleteTvshow(deleteItem))
      .thenAnswer((Invocation realInvocation) async {
    database.mockList.removeAt(deleteItem);
    return true;
  });
  locator.registerSingleton<IDatabaseService>(database);
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
  locator.unregister<IDatabaseService>();
  locator.unregister<ApiService>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
