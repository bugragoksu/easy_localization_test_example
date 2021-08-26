import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:test_example/localization_manager.dart';
import 'package:test_example/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

late BuildContext _context;

Widget makeTestableWidget() {
  return EasyLocalization(
      child: Builder(builder: (context) {
        _context = context;
        return MyApp();
      }),
      startLocale: LocalizationManager.instance.enLocale,
      supportedLocales: LocalizationManager.instance.supportedLocales,
      path: LocalizationManager.instance.assetPath);
}

Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  EasyLocalization.logger.enableLevels = <LevelMessages>[
    LevelMessages.error,
    LevelMessages.warning,
  ];

  await EasyLocalization.ensureInitialized();

  testWidgets('[easy localization default asset loader] test',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pump();

      expect(EasyLocalization.of(_context)!.supportedLocales,
          LocalizationManager.instance.supportedLocales);

      expect(EasyLocalization.of(_context)!.locale,
          LocalizationManager.instance.enLocale);

      final helloFinder = find.text('hello');
      expect(helloFinder, findsOneWidget);

      final worldFinner = find.text('world');
      expect(worldFinner, findsOneWidget);
    });
  });
  testWidgets('[easy localization change to tr locale] test',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestableWidget());

      await tester.pump();

      expect(EasyLocalization.of(_context)!.locale,
          LocalizationManager.instance.enLocale);

      final helloFinder = find.text('hello');
      expect(helloFinder, findsOneWidget);

      final worldFinner = find.text('world');
      expect(worldFinner, findsOneWidget);

      await LocalizationManager.instance.changeLocale(_context);
      await tester.pump();

      expect(EasyLocalization.of(_context)!.locale,
          LocalizationManager.instance.trLocale);

      final helloFinderTr = find.text('merhaba');
      expect(helloFinderTr, findsOneWidget);

      final worldFinnerTr = find.text('dünya');
      expect(worldFinnerTr, findsOneWidget);
    });
  });
}
