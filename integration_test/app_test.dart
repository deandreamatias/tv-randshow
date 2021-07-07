import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tv_randshow/main_prod.dart' as app;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final List<String> tvshows = ['The Office'];

  testWidgets('initial app', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.byKey(Key('app.fav.title')), findsOneWidget);
    expect(find.byKey(Key('app.fav.empty_message')), findsOneWidget);
    expect(find.byKey(Key('app.fav.save')), findsOneWidget);

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Info'), findsOneWidget);

    // Navigate to info tab
    await tester.tap(find.byKey(Key('app.info.tab')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('app.info.title')), findsOneWidget);
    expect(find.byKey(Key('app.info.dark_title')), findsOneWidget);
    expect(find.byKey(Key('app.info.web_title')), findsOneWidget);
    expect(find.byKey(Key('app.info.rate_title')), findsOneWidget);
    expect(find.byKey(Key('app.info.feedback_title')), findsOneWidget);
    expect(find.byKey(Key('app.info.version.title')), findsOneWidget);

    // Show version dialog
    await tester.tap(find.byKey(Key('app.info.version.title')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('app.info.version.dialog_title')), findsOneWidget);
    await tester.tap(find.byKey(Key('app.info.version.dialog_button')));
  });
  testWidgets('tv show flow', (WidgetTester tester) async {
    final LocalizationDelegate delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: <String>['en', 'es', 'pt'],
    );
    await tester.pumpWidget(LocalizedApp(delegate, app.MainApp()));
    await tester.pumpAndSettle();

    // Navigate to search tab
    await tester.tap(find.byKey(Key('app.search.tab')));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('app.search.message')), findsOneWidget);
    expect(find.text('Write a TV show name'), findsOneWidget);

    // Search tv show
    expect(find.byKey(Key('app.search.search_bar')), findsOneWidget);
    await tester.enterText(find.byType(TextField), tvshows.first);
    await tester.pumpAndSettle(Duration(milliseconds: 3500));

    // Save tv show
    expect(find.byKey(Key('app.search.button_fav.2316')), findsOneWidget);
    await tester.tap(find.byKey(Key('app.search.button_fav.2316')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('app.search.button_delete.2316')), findsOneWidget);

    // Navigate to favorites tab
    await tester.tap(find.byKey(Key('app.fav.tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('app.fav.button_random.2316')), findsOneWidget);

    // Get random episode
    await tester.tap(find.byKey(Key('app.fav.button_random.2316')));
    await tester.pumpAndSettle(Duration(milliseconds: 1000));
    expect(find.byKey(Key('app.result.title')), findsOneWidget);

    await tester.tap(find.byKey(Key('app.result.button_random')));
    await tester.pumpAndSettle(Duration(milliseconds: 1000));
    expect(find.byKey(Key('app.result.title')), findsOneWidget);

    // Delete tv show
    await tester.tap(find.byKey(Key('app.loading.button_fav')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('app.fav.button_random.2316')), findsOneWidget);

    await tester.tap(find.byKey(Key('delete:2316')));
    await tester.pumpAndSettle();
    expect(find.byKey(Key('app.delete_dialog.title')), findsOneWidget);
    await tester.tap(find.byKey(Key('app.delete_dialog.button_delete')));
    await tester.pumpAndSettle(Duration(milliseconds: 500));
    expect(find.byKey(Key('app.fav.button_random.2316')), findsNothing);
  });
}
