import 'package:emendo/core/configs/app_theme.dart';
import 'package:emendo/features/intro/presentations/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpGetIt();

  runApp(
    MyApp(),
  );

  /// force portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Emen Do",
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', 'IR'),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
