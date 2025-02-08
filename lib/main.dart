import 'package:emendo/core/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'features/intro/presentations/screens/intro_screen.dart';

void main() {
  runApp(
    Builder(
      builder: (context) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: IntroScreen(),
        );
      },
    ),
  );
}
