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

  test('[easy localization pass argument] test', () {
    expect('gender'.tr(gender: 'male', args: ['Buğra']), 'Merhaba Buğra bey');
    expect('gender'.tr(gender: 'female', args: ['Elif']), 'Merhaba Elif hanim');
    expect('gender'.tr(gender: 'other', args: ['Murat']), 'Merhaba Murat');

    expect('school'.tr(gender: 'university', args: ['Mersin']),
        'Mersin üniversitesi');
    expect(
        'school'.tr(gender: 'highschool', args: ['Mersin']), 'Mersin lisesi');
    expect('school'.tr(gender: 'other', args: ['Mersin']), 'Mersin okulu');
  });
  test('[easy localization linked translation] test', () {
    expect(tr('expenditures.price'), 'fiyat');
    expect(tr('expenditures.total_price', namedArgs: {"value": "1023.45"}),
        "Toplam fiyat 1023.45₺'dir");
  });

  testWidgets('[easy localization plural] test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestableWidget());
      expect('money'.plural(21.5), "You have 21.5 dollars");
      expect('money'.plural(1), "You have 1 dollar");
      expect('money'.plural(0), "You have not money");
      await LocalizationManager.instance.changeLocale(_context);
      await tester.pump();
      expect('money'.plural(21.5), '21.5 liran var');
    });
  });
}
