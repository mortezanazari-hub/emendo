import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  ///light
  static final ThemeData lightTheme = ThemeData(
    primaryColor: LightColors.primeColor,
    brightness: Brightness.light,
    fontFamily: '',
    // hoverColor:,
    focusColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: LightColors.bgColor,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(30),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: LightColors.outLineBorder)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: LightColors.primeColor,width: 0.4),
        ),
       ///check it with ui designer
       focusedErrorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: BorderSide(color: LightColors.primeColor,width: 2),
       ),
      ///check it with ui designer
      errorStyle: const TextStyle(color: LightColors.primeColor),
       suffixIconColor: Colors.grey.shade800,
      ///check it with ui designer
      errorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: const BorderSide(color: Colors.red,width: 1),
       ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LightColors.primeColor,
        textStyle: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )
      )
    ),

  );


  ///dark
  static final ThemeData darkTheme = ThemeData(
    primaryColor: DarkColors.primeColor,
    brightness: Brightness.dark,
    fontFamily: '',
    splashFactory: NoSplash.splashFactory,
    // hoverColor:
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    scaffoldBackgroundColor: DarkColors.bgColor,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: LightColors.outLineBorder)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: LightColors.primeColor,width: 0.4),
      ),
      ///check it with ui designer
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: LightColors.primeColor,width: 2),
      ),
      ///check it with ui designer
      errorStyle: const TextStyle(color: LightColors.primeColor),
      suffixIconColor: Colors.grey.shade800,
      ///check it with ui designer
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red,width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: LightColors.primeColor,
            textStyle: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            )
        )
    ),
  );
}