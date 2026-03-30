// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF232f3e),
  scaffoldBackgroundColor: const Color(0xFFfafafa),
  disabledColor: const Color(0xFFA0A4A8),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF232f3e),
    brightness: Brightness.light,
    primary: const Color(0xFF232f3e),
    error: const Color(0xFFE84D4F),
  ),
  primarySwatch: AppColor.primarySwatchValueColor,
);

class AppColor {
  static const int primarySwatchValue = 0xFF232f3e;
  static const MaterialColor primarySwatchValueColor = MaterialColor(
    primarySwatchValue,
    <int, Color>{
      50: Color(primarySwatchValue),
      100: Color(primarySwatchValue),
      200: Color(primarySwatchValue),
      300: Color(primarySwatchValue),
      400: Color(primarySwatchValue),
      500: Color(primarySwatchValue),
      600: Color(primarySwatchValue),
      700: Color(primarySwatchValue),
      800: Color(primarySwatchValue),
      900: Color(primarySwatchValue),
    },
  );
  static const Color hoverBlueColor = Color(0xFFEEEDFD);
}
