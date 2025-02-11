import 'package:emendo/core/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/intro/presentations/screens/intro_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Builder(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en', 'US'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: IntroScreen(),
        );
      },
    ),
  );
}
