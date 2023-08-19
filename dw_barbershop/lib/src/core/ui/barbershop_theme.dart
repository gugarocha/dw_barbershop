import 'package:flutter/material.dart';

import 'constants.dart';

sealed class BarbershopTheme {
  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: ColorsConstants.grey),
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    fontFamily: FontConstants.fontFamily,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsConstants.brow),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: FontConstants.fontFamily,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: ColorsConstants.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorsConstants.brow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsConstants.brow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(
          width: 1,
          color: ColorsConstants.brow,
        ),
      ),
    ),
  );
}
