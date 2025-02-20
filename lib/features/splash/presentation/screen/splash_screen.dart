import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

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
    _animateLogo();
    _showDeveloperTextAfterDelay();
  }

  void _animateLogo() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _size = 200;
      });
      _animateLetters();
    });
  }

  void _animateLetters() {
    for (int i = 0; i < _letters.length; i++) {
      Future.delayed(
          Duration(milliseconds: 1000 + i * (900 ~/ _letters.length)), () {
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
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _changeColor = true;
        });
      }
    });
  }

  void _showDeveloperTextAfterDelay() {
    Future.delayed(const Duration(milliseconds: 2500), () {
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
            Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 750),
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
                    duration: const Duration(milliseconds: 10),
                    opacity: _visible[index] ? 1.0 : 0.0,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 500),
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
              duration: const Duration(milliseconds: 1000),
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
                          context: context, color: LightColors.thirdText),
                    ),
                    Text(
                      "EmenSoft",
                      style: AppTextStyles.base(
                          context: context, color: LightColors.secondText),
                    ),
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
