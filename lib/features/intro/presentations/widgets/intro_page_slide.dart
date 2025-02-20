import 'package:emendo/common/extensions/context_extensions.dart';
import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_images.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/intro/presentations/widgets/highlight_word_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
