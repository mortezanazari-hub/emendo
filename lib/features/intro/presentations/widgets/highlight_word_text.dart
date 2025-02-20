import 'package:auto_size_text/auto_size_text.dart';
import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';

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
