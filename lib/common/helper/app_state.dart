import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final bool isRtl;
  final bool? isFirstTime;

  const AppState({
    this.isFirstTime,
    super.key,
    required this.isRtl,
    required super.child,
  });

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>()!;
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return isRtl != oldWidget.isRtl || isFirstTime != oldWidget.isFirstTime;
  }
}
