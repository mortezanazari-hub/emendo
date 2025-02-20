import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends InheritedWidget {
  final bool isRtl;

  const AppState({
    super.key,
    required this.isRtl,
    required super.child,
  });

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>()!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return isRtl != oldWidget.isRtl;
  }

  static Future<bool?> get isFirstTime async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('app_state');
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap['isFirstTime'] as bool?;
    }
    return null;
  }

  static Future<void> setIsFirstTime(bool? value) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> jsonMap = {'isFirstTime': value};
    await prefs.setString('app_state', json.encode(jsonMap));
  }
}
