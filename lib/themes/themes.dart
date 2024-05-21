import 'package:flutter/material.dart';

class Themes {
  static final mainThemeDark = ThemeData.dark(useMaterial3: true);
  static final mainThemeLight = ThemeData.light(useMaterial3: true);
}

class TextStyles {
  static const textStyle20 = TextStyle(fontSize: 20);

  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const textStyle13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static const bigTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static const appBarStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
}
