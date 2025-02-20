import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/common/widgets/app_buttons.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_images.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/intro/presentations/screens/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    AppImages.getStartScreen,
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
                    AppImages.miniLogo,
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
                      padding: EdgeInsets.all(constraints.maxWidth * 0.08),
                      child: Column(
                        spacing: constraints.maxHeight * 0.025,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ///Emen
                                localization.getStartedScreen_emen,
                                style: AppTextStyles.logoBase(context: context),
                              ),
                              Text(
                                ///Do
                                " ${localization.getStartedScreen_do}",
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
                            ///Building Better Workplaces
                            localization.getStartedScreen_title,
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
                            ///Create a unique emotional story that describes better than words
                            localization.getStartedScreen_subTitle,
                            style: AppTextStyles.base(
                                context: context,
                                fontSize: 13,
                                color: context.isDarkMode
                                    ? DarkColors.thirdText
                                    : LightColors.thirdText,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          AppButtons.primaryBold(
                            context: context,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IntroSlider()));
                            },
                            ///Get Started
                            text: localization.getStartedScreen_buttonName,
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
