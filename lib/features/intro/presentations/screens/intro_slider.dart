import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? DarkColors.bgColor
                    : LightColors.bgColor,
              ),
              child: Image.asset(
                "assets/images/png/intro_screen_slide1.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                isAntiAlias: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxHeight * 0.05),
              child: Column(
                children: [
                  Text(
                    "Task Management",
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
