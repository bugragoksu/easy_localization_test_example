import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationManager {
  LocalizationManager._privateConstructor();

  static final LocalizationManager _instance =
      LocalizationManager._privateConstructor();

  static LocalizationManager get instance => _instance;

  Locale enLocale = Locale("en");
  Locale trLocale = Locale("tr");

  List<Locale> get supportedLocales => [trLocale, enLocale];

  String get assetPath => "assets/translations";

  Future<void> changeLocale(BuildContext context) async {
    if (context.locale == trLocale) {
      await context.setLocale(enLocale);
    } else {
      await context.setLocale(trLocale);
    }
  }
}
