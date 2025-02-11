import 'package:emendo/core/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'features/intro/presentations/screens/intro_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Builder(
      builder: (context) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: IntroScreen(),
        );
      },
    ),
  );
}
