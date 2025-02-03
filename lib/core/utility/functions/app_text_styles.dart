// یک کلاس برای مدیریت تمام استایل‌های متنی شما
import 'package:emendo/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  ///General TextStyle
  static TextStyle base({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16.0,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontStyle: fontStyle ?? FontStyle.normal,
      color: color ?? const Color(0xFF000000),
      fontFamily: fontFamily ?? 'OpenSans',
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      overflow: overflow,
    );
  }

  ///base for logo
  static TextStyle logoBase({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextOverflow? overflow,
  }) {
    return base(
      fontSize: fontSize ?? 63.0,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontStyle: fontStyle ?? FontStyle.normal,
      color: color ?? AppColors.color8,
      fontFamily: fontFamily ?? 'MadimiOne',
      letterSpacing: letterSpacing ?? 1.5,
      wordSpacing: wordSpacing,
      decoration: decoration,
      decorationStyle: decorationStyle,
      decorationColor: decorationColor,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      overflow: overflow,
    );
  }



}
