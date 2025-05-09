import 'package:dots_indicator/dots_indicator.dart';
import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/common/helper/is_rtl_mode.dart';
import 'package:emendo/common/helper/shared_operator.dart';
import 'package:emendo/core/configs/assets.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:emendo/features/intro/presentations/widgets/intro_page_slide.dart';
import 'package:emendo/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _pageController = PageController();
  double _currentIndex = 0.0;
  bool getStart = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Column(
                children: [
                  ///page view
                  SizedBox(
                    height: constraints.maxHeight * 0.88,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index.toDouble();
                        });
                      },
                      controller: _pageController,
                      children: [
                        IntroPageSlide(
                          constraints: constraints,
                          index: 1,
                          text: localization.introSlide_1_text,
                          highlightedWord:
                              localization.introSlide_1_highlightedWord,
                        ),
                        IntroPageSlide(
                          constraints: constraints,
                          index: 2,
                          text: localization.introSlide_2_text,
                          highlightedWord:
                              localization.introSlide_2_highlightedWord,
                        ),
                        IntroPageSlide(
                          constraints: constraints,
                          index: 3,
                          text: localization.introSlide_3_text,
                          highlightedWord:
                              localization.introSlide_3_highlightedWord,
                        ),
                      ],
                    ),
                  ),

                  ///of main page
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.07),
                      child: Column(
                        children: [
                          //SizedBox(height: constraints.maxHeight * 0.015),
                          Flexible(
                            child: Row(
                              children: [
                                DotsIndicator(
                                  position: _currentIndex,
                                  dotsCount: 3,
                                  animate: true,
                                  decorator: DotsDecorator(
                                    color: context.isDarkMode
                                        ? DarkColors.disableSliderColor
                                        : LightColors.disableSliderColor,
                                    activeColor: context.isDarkMode
                                        ? DarkColors.primeColor
                                        : LightColors.primeColor,
                                    size: const Size(8, 8),
                                    activeSize: const Size(20.0, 6.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(localization.skip)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: context.isRtl
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: SizedBox(
                  height: constraints.maxHeight * 0.185,
                  child: Ink(
                    child: InkWell(
                      onTap: () {
                        if (_pageController.page!.toInt() < 2) {
                          _pageController.animateToPage(
                              _pageController.page!.toInt() + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                        if (_pageController.page!.toInt() == 1) {
                          setState(() {
                            getStart = true;
                          });
                        }
                        if (_pageController.page!.toInt() == 2) {
                          locator<SharedPrefOperator>().saveIntroState();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Transform(
                        alignment: Alignment.center,
                        transform: context.isRtl
                            ? (Matrix4.identity()..scale(-1.0, 1.0, 1.0))
                            : (Matrix4.identity()..scale(1.0, 1.0, 1.0)),
                        child: SvgPicture.asset(
                          alignment: Alignment(1, 1),
                          Assets.nextButtonIntro,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: constraints.maxHeight * 0.07,
                  right: context.isRtl
                      ? (constraints.maxWidth * 0.89)
                      : (constraints.maxWidth * 0.05),
                  // left: context.isRtl ? (constraints.maxWidth * 0.05) : 0,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: context.isDarkMode
                        ? DarkColors.bgColor
                        : LightColors.bgColor,
                  ))
            ],
          ),
        );
      }),
    );
  }
}
