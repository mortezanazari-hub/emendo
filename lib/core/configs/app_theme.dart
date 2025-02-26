import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  ///light
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: LightColors.primeColor,
      brightness: Brightness.light,
      fontFamily: 'OpenSans',
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      scaffoldBackgroundColor: LightColors.bgColor,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: LightColors.primeColor,width: 1.5)
        ),
        contentPadding: const EdgeInsets.all(30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: LightColors.outLineBorder, width: 1.5),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: LightColors.primeColor)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: LightColors.primeColor, width: 1.5),
        ),
        errorStyle: const TextStyle(color: LightColors.primeColor),
        suffixIconColor: Colors.grey.shade800,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: LightColors.primeColor, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: LightColors.primeColor,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
    );
  }

  ///dark
  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: DarkColors.primeColor,
      brightness: Brightness.dark,
      fontFamily: 'OpenSans',
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      scaffoldBackgroundColor: DarkColors.bgColor,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: DarkColors.primeColor,width: 1.5)
        ),
        contentPadding: const EdgeInsets.all(30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: DarkColors.outLineBorder, width: 1.5),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: DarkColors.primeColor)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: DarkColors.primeColor, width: 1.5),
        ),
        errorStyle: const TextStyle(color: DarkColors.primeColor),
        suffixIconColor: Colors.grey.shade800,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: DarkColors.primeColor, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: LightColors.primeColor,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
    );
  }
}
