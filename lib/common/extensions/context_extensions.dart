import 'package:flutter/material.dart';
import 'package:emendo/common/helper/app_state.dart';

extension BuildContextExtensions on BuildContext {
  bool get isRtl => AppState.of(this).isRtl;

  Future<bool?> get isFirstTime async => await AppState.isFirstTime;

  Future<void> setIsFirstTime(bool? value) async {
    await AppState.setIsFirstTime(value);
  }
}