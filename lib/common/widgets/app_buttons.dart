import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/configs/app_text_styles.dart';

class AppBaseButton extends StatelessWidget {
  ///size of button
  final double? width;
  final double? height;

  ///text specific
  final double? fontSize;
  final FontWeight? fontWeight;

  /// The text displayed on the button.
  final String text;

  /// The callback function when the button is pressed.
  final VoidCallback? onPressed;

  /// The callback function when the button is long pressed.
  final VoidCallback? onLongPress;

  /// Focus node for handling focus.
  final FocusNode? focusNode;

  /// Whether this button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// How to clip the content (for images, etc.).
  final Clip clipBehavior;

  // --- styleFrom parameters with default values (Flutter 2.5+ / 3.x) ---
  final Color foregroundColor; // text/icon color
  final Color disabledForegroundColor; // text/icon color when disabled
  final Color backgroundColor; // background color
  final Color disabledBackgroundColor; // background color when disabled
  final Color shadowColor; // shadow color
  final double elevation; // button elevation
  final TextStyle textStyle; // text style
  final EdgeInsetsGeometry padding; // button padding
  final Size minimumSize; // minimum size
  final BorderSide side; // border side
  final OutlinedBorder shape; // shape of the button
  final MouseCursor? enabledMouseCursor; // cursor when enabled
  final MouseCursor? disabledMouseCursor; // cursor when disabled
  final VisualDensity visualDensity; // adjusts how compact the button is
  final MaterialTapTargetSize
      tapTargetSize; // configures the minimum tap target size
  final Duration animationDuration; // duration of animations
  final bool
      enableFeedback; // whether detected gestures should provide feedback
  final Alignment alignment; // aligns the child within the button

  const AppBaseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,

    // Default values for styleFrom:
    this.foregroundColor = Colors.white,
    this.disabledForegroundColor = Colors.grey,
    this.backgroundColor = Colors.blue,
    this.disabledBackgroundColor = Colors.grey,
    this.shadowColor = Colors.black,
    this.elevation = 14,
    this.textStyle = const TextStyle(color: Colors.white),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.minimumSize = const Size(64, 36),
    this.side = const BorderSide(color: Colors.transparent),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    this.enabledMouseCursor,
    this.disabledMouseCursor,
    this.visualDensity = VisualDensity.standard,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.animationDuration = kThemeChangeDuration,
    this.enableFeedback = true,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: TextButton(
              onPressed: onPressed,
              onLongPress: onLongPress,
              focusNode: focusNode,
              autofocus: autofocus,
              clipBehavior: clipBehavior,
              style: TextButton.styleFrom(
                foregroundColor: foregroundColor,
                disabledForegroundColor: disabledForegroundColor,
                backgroundColor: backgroundColor,
                disabledBackgroundColor: disabledBackgroundColor,
                shadowColor: shadowColor,
                elevation: elevation,
                textStyle: textStyle,
                padding: padding,
                minimumSize: minimumSize,
                side: side,
                shape: shape,
                enabledMouseCursor: enabledMouseCursor,
                disabledMouseCursor: disabledMouseCursor,
                visualDensity: visualDensity,
                tapTargetSize: tapTargetSize,
                animationDuration: animationDuration,
                enableFeedback: enableFeedback,
                alignment: alignment,
              ),
              child: Text(text,
                  style: AppTextStyles.base(
                      color: Colors.white,
                      fontSize: fontSize,
                    fontWeight: fontWeight,
                    context: context,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

/// A helper class with static methods to create different styled buttons
/// using [AppBaseButton].
class AppButtons {
  static AppBaseButton primary({
    required String text,
    required BuildContext context,
    VoidCallback? onPressed,
  }) {
    final isDark = context.isDarkMode;
    return AppBaseButton(
      width: 300,
      height: 48,
      text: text,
      onPressed: onPressed,
      foregroundColor: isDark ? DarkColors.white : LightColors.white,
      backgroundColor: isDark ? DarkColors.primeColor : LightColors.primeColor,
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  static AppBaseButton primaryBold({
    required String text,
    VoidCallback? onPressed,
    required BuildContext context,
  }) {
    final isDark = context.isDarkMode;
    return AppBaseButton(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      // width: 300,
      height: 48,
      text: text,
      onPressed: onPressed,
      foregroundColor: isDark ? DarkColors.white : LightColors.white,
      backgroundColor: isDark ? DarkColors.primeColor : LightColors.primeColor,
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}