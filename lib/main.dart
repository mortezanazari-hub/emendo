import 'package:emendo/common/helper/app_state.dart';
import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/intro/presentations/screens/intro_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    AppState(
      isRtl: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isRtl = AppState.of(context).isRtl;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: isRtl ? const Locale('ar', 'SA') : const Locale('en', 'US'),
        theme: AppTheme.getTheme(isDark: context.isDarkMode),
        darkTheme: AppTheme.getTheme(isDark: context.isDarkMode),
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}