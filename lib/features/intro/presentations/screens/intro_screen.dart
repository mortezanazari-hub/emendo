import 'package:emendo/common/helper/is_dark_mode.dart';
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
  final GlobalKey _redKey = GlobalKey();
  double redHeight = 0;

  void updateRedHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _redKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.size.height != redHeight) {
        setState(() {
          redHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                ///bg and logo stack
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      key: _redKey,
                      child: Image.asset(
                        "assets/images/png/get_start_screen.png",
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (frame != null || wasSynchronouslyLoaded) {
                            updateRedHeight();
                          }
                          return child;
                        },
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Image.asset(
                        "assets/images/png/mini_logo.png",
                        height: 30,
                      ),
                    ),
                  ],
                ),

                if (redHeight > 0)
                  Positioned(
                    top: redHeight - 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? DarkColors.bgColor
                            : LightColors.bgColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30),

                          ///logotype
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
                          Text(
                            "Create a unique emotional story that\ndescribes better than words ",
                            style: AppTextStyles.base(
                                context:context,
                                fontSize: 13,
                                color: context.isDarkMode
                                    ? DarkColors.thirdText
                                    : LightColors.thirdText,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          AppButtons.primaryBold(
                            context: context,
                            onPressed: () {},
                            text: "Started",
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
