// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> tr = {
    "hello": "merhaba",
    "world": "dünya",
    "expenditures": {
      "price": "fiyat",
      "symbol": "₺",
      "total_price":
          "Toplam @:expenditures.price {value}@:expenditures.symbol'dir"
    }
  };
  static const Map<String, dynamic> en = {
    "hello": "hello",
    "world": "world",
    "expenditures": {
      "price": "price",
      "symbol": "\$",
      "total_price":
          "Total @:expenditures.price is {value}@:expenditures.symbol"
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "tr": tr,
    "en": en
  };
}
