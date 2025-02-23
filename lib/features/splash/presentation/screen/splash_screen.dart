import 'package:emendo/common/helper/shared_operator.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/auth/presentation/screens/register_screen.dart';
import 'package:emendo/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../intro/presentations/screens/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _size = 0;
  final List<bool> _visible = List.generate(6, (_) => false);
  final List<String> _letters = ['E', 'M', 'E', 'N', 'D', 'O'];
  bool _changeColor = false;
  bool _showDeveloperText = false;

  @override
  void initState() {
    super.initState();
    goToNextScreen();
    _animateLogo();
    _showDeveloperTextAfterDelay();
  }

  Future<void> goToNextScreen() async {
    var introState = locator<SharedPrefOperator>().getIntroState();
    await Future.delayed(Duration(seconds: 2));
    if (introState) {
      if(mounted)Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen(),));
    } else {
      if(mounted)Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
    }
  }

  ///animations
  void _animateLogo() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _size = 200;
      });
      _animateLetters();
    });
  }

  void _animateLetters() {
    for (int i = 0; i < _letters.length; i++) {
      Future.delayed(Duration(milliseconds: 500 + i * (480 ~/ _letters.length)),
          () {
        if (mounted) {
          setState(() {
            _visible[i] = true;
          });
          if (i == _letters.length - 1) {
            _changeDoColor();
          }
        }
      });
    }
  }

  void _changeDoColor() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _changeColor = true;
        });
      }
    });
  }

  void _showDeveloperTextAfterDelay() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _showDeveloperText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: _size,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _letters.length,
                  (index) => AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: _visible[index] ? 1.0 : 0.0,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: AppTextStyles.logoBase(context: context).copyWith(
                        color: (index >= _letters.length - 2 && _changeColor)
                            ? LightColors.primeColor
                            : AppTextStyles.logoBase(context: context).color,
                      ),
                      child: Text(_letters[index]),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _showDeveloperText ? 1.0 : 0.0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "App developed by ",
                      style: AppTextStyles.base(
                        context: context,
                        color: LightColors.thirdText,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "EmenSoft",
                      style: AppTextStyles.base(
                        context: context,
                        color: LightColors.secondText,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
