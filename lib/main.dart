import 'package:flutter/material.dart';

import 'features/splash_screen/presentations/screens/splash_screen.dart';

void main() {
  runApp(
    Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    ),
  );
}
