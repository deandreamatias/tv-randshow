import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

FlutterDriver driver;

void main() {
  group('TV Randshow app', () {
    List<String> tvshows = ['The Office'];
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('initial app', () async {
      await driver.waitUntilFirstFrameRasterized();
      await compareTextKey(
          'app.fav.title', 'Your favorite TV shows to get a random episode');
      await compareTextKey('app.fav.empty_message',
          'Search TV show to add in your favorites TV shows');
      // BottomBar
      await compareText('Favorites', 'Favorites');
      await compareText('Search', 'Search');
      await compareText('Info', 'Info');
    });

    test('search tv show', () async {
      await tapKey('app.search.tab');

      await compareTextKey('app.search.message', 'Search a TV show in top bar');
      expect(await driver.getText(find.text('Write a TV show name')),
          equals('Write a TV show name'));

      await tapKey('app.search.search_bar');
      await driver.enterText(tvshows.first);
      await pause(3500);

      await compareTextKey('app.search.button_fav.2316', 'ADD TO FAV');
      await tapKey('app.search.button_fav.2316');
      await pause();
      await compareTextKey('app.search.button_delete.2316', 'DELETE');
    });
    test('show favorites list', () async {
      await tapKey('app.fav.tab');

      await driver.waitForAbsent(find.byValueKey('app.fav.loading'));
      await pause(500);
      await compareText(tvshows.first, tvshows.first);
    });
    test('get random episode', () async {
      await compareTextKey('app.fav.button_random.2316', 'RANDOM');
      await tapKey('app.fav.button_random.2316');

      await driver.waitForAbsent(find.byValueKey('app.loading.title'));
      await compareTextKey(
          'app.result.title', 'This is the TV show episode chosen at random!');

      await tapKey('app.result.button_random');
      await driver.waitForAbsent(find.byValueKey('app.loading.title'));
      await compareTextKey(
          'app.result.title', 'This is the TV show episode chosen at random!');

      await tapKey('app.loading.button_fav');
      await pause(500);
    });

    test('delete favorite show', () async {
      await compareText(tvshows.first, tvshows.first);

      await tapKey('delete:1');
      await driver.waitFor(find.byValueKey('app.delete_dialog.title'));
      await tapKey('app.delete_dialog.button_delete');
      await pause(500);
      await driver.waitForAbsent(find.text(tvshows.first));

      await pause(500);
    });

    test('info view', () async {
      await tapKey('app.info.tab');

      await compareTextKey('app.info.title', 'Info about TV Randshow');
      await compareTextKey('app.info.web_title', 'Web app');
      await compareTextKey('app.info.rate_title', 'Review');
      await compareTextKey('app.info.feedback_title', 'Feedback');
      await compareTextKey('app.info.version.title', 'Version changelog');

      await tapKey('app.info.version.title');
      await driver.waitFor(find.byValueKey('app.info.version.dialog_title'));
      await tapKey('app.info.version.dialog_button');

      await compareTextKey('app.info.dark_title', 'Dark theme');

      await pause(500);
    });
  });
}

/// Tap widget by [key] and pause 300 ms
Future<void> tapKey(String key) async {
  await driver.tap(find.byValueKey(key));
  await pause();
}

/// Get text by [key] and compare to [text]
Future<void> compareTextKey(String key, String text) async {
  expect(await driver.getText(find.byValueKey(key)), equals(text));
}

/// Get text by [value] and compare with [text]
Future<void> compareText(String value, String text) async {
  expect(await driver.getText(find.text(value)), equals(text));
}

Future<void> pause([int miliseconds = 300]) async {
  await Future<Duration>.delayed(Duration(milliseconds: miliseconds));
}
