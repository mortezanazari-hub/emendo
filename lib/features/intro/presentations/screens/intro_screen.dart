import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/features/intro/presentations/screens/intro_slider.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/app_buttons.dart';
import '../../../../core/configs/app_colors.dart';
import '../../../../core/configs/app_text_styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/png/get_start_screen.png",
                    width: double.infinity,
                    height: constraints.maxHeight * 0.50,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.50,
                    color: context.isDarkMode
                        ? DarkColors.bgColor
                        : LightColors.bgColor,
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: 20,
                child: SafeArea(
                  child: Image.asset(
                    "assets/images/png/mini_logo.png",
                    height: 30,
                  ),
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.40,
                left: 0,
                right: 0,
                child: Container(
                  height: constraints.maxHeight * 0.60,
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? DarkColors.bgColor
                        : LightColors.bgColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        spacing: constraints.maxHeight * 0.025,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Emen",
                                style: AppTextStyles.logoBase(context: context),
                              ),
                              Text(
                                " Do",
                                style: AppTextStyles.logoBase(
                                  context: context,
                                  color: context.isDarkMode
                                      ? DarkColors.primeColor
                                      : LightColors.primeColor,
                                ),
                              ),
                            ],
                          ),
                          //SizedBox(height: constraints.maxHeight * 0.02),
                          Text(
                            "Building Better \nWorkplaces ",
                            style: AppTextStyles.base(
                                context: context,
                                color: context.isDarkMode
                                    ? DarkColors.secondText
                                    : LightColors.secondText,
                                fontSize: 34,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          //SizedBox(height: constraints.maxHeight * 0.02),
                          Text(
                            "Create a unique emotional story that\ndescribes better than words ",
                            style: AppTextStyles.base(
                                context: context,
                                fontSize: 13,
                                color: context.isDarkMode
                                    ? DarkColors.thirdText
                                    : LightColors.thirdText,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          //  SizedBox(height: constraints.maxHeight * 0.03),
                          AppButtons.primaryBold(
                            context: context,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IntroSlider()));
                            },
                            text: "Started",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}