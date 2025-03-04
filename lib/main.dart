import 'package:emendo/core/configs/app_theme.dart';
import 'package:emendo/core/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/home/presentations/screen/cubit/bottom_nav_cubit.dart';
import 'features/home/presentations/screen/main_wrapper.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpGetIt();
  await Supabase.initialize(
      url: Constants.supaBaseUrl,
      anonKey: Constants.supaBaseKey
  );

  /// force portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavCubit(),),

        ],
        child: MaterialApp(
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
          home: MainWrapper(),
        )
    );
  }
}