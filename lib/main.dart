import 'package:flutter/material.dart';
import 'features/intro/presentations/screens/intro_screen.dart';


void main() {
  runApp(
    Builder(
      builder: (context) {
        return MaterialApp(
          theme: ThemeData(fontFamily: "OpenSans"),
          debugShowCheckedModeBanner: false,
          home: IntroScreen(),
        );
      },
    ),
  );
}
