import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_images.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:emendo/common/extensions/context_extensions.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _pageController = PageController();
  double _currentIndex = 0.0;

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
                          horizontal: constraints.maxWidth * 0.07
                      ),
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
                                    onPressed: () {}, child: Text(localization.skip)),
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
                      onTap: () {},
                      child: Transform(
                        alignment: Alignment.center,
                        transform: context.isRtl
                            ? (Matrix4.identity()..scale(-1.0, 1.0, 1.0))
                            : (Matrix4.identity()..scale(1.0, 1.0, 1.0)),
                        child: SvgPicture.asset(
                          alignment: Alignment(1, 1),
                          AppImages.nextButtonIntro,
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

class IntroPageSlide extends StatelessWidget {
  final BoxConstraints constraints;
  final int index;
  final String text;
  final String highlightedWord;

  const IntroPageSlide({
    super.key,
    required this.constraints,
    required this.index,
    required this.text,
    required this.highlightedWord,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Column(
      children: [
        Container(
          height: constraints.maxHeight * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? DarkColors.bgColor : LightColors.bgColor,
          ),
          child: Image.asset(
            AppImages.introScreenSlide(index),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            isAntiAlias: true,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxHeight * 0.05),
          child: Column(
            children: [
              //task management
              Row(
                children: [
                  Flexible(
                    child: Text(
                      localization.taskManagement,
                      textDirection:
                          context.isRtl ? TextDirection.rtl : TextDirection.ltr,
                      style: AppTextStyles.base(
                        context: context,
                        color: context.isDarkMode
                            ? DarkColors.primeColor
                            : LightColors.primeColor,
                        //fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //first line text
              Row(
                children: [
                  Flexible(
                    child: HighlightWordText(
                      text: text,
                      highlightWord: highlightedWord,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class HighlightWordText extends StatelessWidget {
  final String text;
  final String highlightWord;

  const HighlightWordText({
    super.key,
    required this.text,
    required this.highlightWord,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle normalStyle = AppTextStyles.base(
      context: context,
      color: context.isDarkMode ? DarkColors.mainText : LightColors.mainText,
      fontSize: 35,
      // fontWeight: FontWeight.bold,
    );
    TextStyle highlightStyle = AppTextStyles.base(
      context: context,
      color:
          context.isDarkMode ? DarkColors.primeColor : LightColors.primeColor,
      fontSize: 35,
      fontWeight: FontWeight.bold,
    );

    List<TextSpan> spans = [];

    text.splitMapJoin(
      RegExp(highlightWord, caseSensitive: false),
      onMatch: (match) {
        spans.add(TextSpan(text: match[0], style: highlightStyle));
        return '';
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: normalStyle));
        return '';
      },
    );

    return AutoSizeText.rich(
      TextSpan(children: spans),
      style: normalStyle,
      minFontSize: 20, // Set a minimum font size
      maxLines: 3, // Allow text to wrap to the next line
      overflow: TextOverflow.ellipsis,
    );
  }
}