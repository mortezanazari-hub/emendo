import 'package:flutter/material.dart';

extension RtlMode on BuildContext{
  bool get isRtl {
    return Directionality.of(this) == TextDirection.rtl;
  }
}