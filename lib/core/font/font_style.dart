import 'package:find_shop_test/core/theme/theme_app.dart';
import 'package:flutter/material.dart';

class FontAppStyle {
  static TextStyle fontLarge =
      const TextStyle(fontWeight: FontWeight.w800, fontSize: 16);
  static TextStyle fontSmall = const TextStyle(
    fontWeight: FontWeight.w800,
  );

  static TextStyle fontLargeWhite = const TextStyle(
      fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white);

  static TextStyle fontLargeBlue = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 16, color: ThemeApp.blue);

  static TextStyle fontSmallBlue = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 10, color: ThemeApp.blue);

  static TextStyle fontSmallWhite = const TextStyle(
      fontWeight: FontWeight.w800, fontSize: 10, color: Colors.white);
}
