// ignore_for_file: avoid-ignoring-return-values
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tv_randshow/main_prod.dart' as main_prod;
import 'package:tv_randshow/ui/app.dart' as app;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final List<String> tvshows = ['The Office'];

  testWidgets('initial app', (WidgetTester tester) async {
    await main_prod.main();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('app.fav.title')), findsOneWidget);
    expect(find.byKey(const Key('app.fav.empty_message')), findsOneWidget);

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Navigate to settings tab.
    await tester.tap(find.byKey(const Key('app.info.tab')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('app.info.title')), findsOneWidget);
    expect(find.byKey(const Key('app.info.dark_title')), findsOneWidget);
    expect(find.byKey(const Key('app.info.web_title')), findsOneWidget);
    expect(find.byKey(const Key('app.info.rate_title')), findsOneWidget);
    expect(find.byKey(const Key('app.info.feedback_title')), findsOneWidget);
    expect(find.byKey(const Key('app.info.version.title')), findsOneWidget);

    // Show version dialog.
    await tester.tap(find.byKey(const Key('app.info.version.title')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('app.info.version.dialog_title')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const Key('app.info.version.dialog_button')));
  });
  testWidgets('tv show flow', (WidgetTester tester) async {
    final LocalizationDelegate delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: <String>['en', 'es', 'pt'],
    );
    await tester.pumpWidget(LocalizedApp(delegate, const app.App()));
    await tester.pumpAndSettle();

    // Navigate to search tab.
    await tester.tap(find.byKey(const Key('app.search.tab')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('app.search.message')), findsOneWidget);
    expect(find.text('Write a TV show name'), findsOneWidget);

    // Search tv show.
    expect(find.byKey(const Key('app.search.search_bar')), findsOneWidget);
    await tester.enterText(find.byType(TextField), tvshows.first);
    await waitUntil(
      tester: tester,
      conditionMet:
          () =>
              find
                  .byKey(const Key('app.search.button_fav.2316'))
                  .evaluate()
                  .isNotEmpty,
    );

    // Save tv show.
    expect(find.byKey(const Key('app.search.button_fav.2316')), findsOneWidget);
    await tester.tap(find.byKey(const Key('app.search.button_fav.2316')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('app.search.button_delete.2316')),
      findsOneWidget,
    );

    // Navigate to favorites tab.
    await tester.tap(find.byKey(const Key('app.fav.tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('2316')), findsOneWidget);
    expect(find.byKey(const Key('app.fav.button_random.2316')), findsOneWidget);
    expect(find.byKey(const Key('app.fav.save')), findsOneWidget);

    // Get random episode.
    await tester.tap(find.byKey(const Key('app.fav.button_random.2316')));
    await waitUntil(
      tester: tester,
      conditionMet:
          () =>
              find
                  .byKey(const Key('app.result.episode.title'))
                  .evaluate()
                  .isNotEmpty,
    );
    expect(find.byKey(const Key('app.result.episode.title')), findsOneWidget);

    await tester.tap(find.byKey(const Key('app.result.episode.button_random')));
    await waitUntil(
      tester: tester,
      conditionMet:
          () =>
              find
                  .byKey(const Key('app.result.button_fav'))
                  .evaluate()
                  .isNotEmpty,
    );
    expect(find.byKey(const Key('app.result.episode.title')), findsOneWidget);
    expect(find.byKey(const Key('app.result.button_fav')), findsOneWidget);
    await tester.pumpAndSettle();

    // Delete tv show.
    await tester.tap(find.byKey(const Key('app.result.button_fav')));
    await waitUntil(
      tester: tester,
      conditionMet:
          () =>
              find
                  .byKey(const Key('app.fav.button_random.2316'))
                  .evaluate()
                  .isNotEmpty,
    );
    expect(find.byKey(const Key('app.fav.button_random.2316')), findsOneWidget);

    await tester.tap(find.byKey(const Key('delete:2316')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('app.delete_dialog.title')), findsOneWidget);
    await tester.tap(find.byKey(const Key('app.delete_dialog.button_delete')));
    await waitUntil(
      tester: tester,
      conditionMet:
          () =>
              find
                  .byKey(const Key('app.fav.button_random.2316'))
                  .evaluate()
                  .isEmpty,
    );
    expect(find.byKey(const Key('app.fav.button_random.2316')), findsNothing);
  });
}

// This function is from this article
// https://vini2001.medium.com/the-ultimate-guide-to-flutter-integration-testing-8aabb7749476.
Future waitUntil({
  required WidgetTester tester,
  required bool Function() conditionMet,
  Duration timeout = const Duration(seconds: 30),
}) async {
  final binding = tester.binding;

  return TestAsyncUtils.guard<int>(() async {
    final endTime = binding.clock.fromNowBy(timeout);
    var count = 0;
    while (true) {
      // Stop loop if it has timed out or if condition is reached.
      if ((binding.clock.now().isAfter(endTime) &&
              !binding.hasScheduledFrame) ||
          conditionMet()) {
        break;
      }
      // Triggers ui frames.
      await binding.pump(const Duration(milliseconds: 100));
      count += 1;
    }

    return count;
  });
}
