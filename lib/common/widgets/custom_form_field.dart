import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emendo/core/configs/app_text_styles.dart';

import '../../core/configs/app_colors.dart';


class CustomFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final BuildContext? context;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final bool isNumber;
  final int? maxLength;
  final EdgeInsets contentPadding;
  final String? Function(String? value)? validator;
  final ValueChanged<String>? onSubmit;
  final Color prefixColor;
  // final TextStyle style;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;

  const CustomFormField({
    super.key,
    this.onTap,
    this.context,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.number,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.validator,
    required this.onSubmit,
    this.isNumber = false,
    this.maxLength,
    this.focusNode,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    // this.style = TextStyle(
    //   color: context.isDarkMode ? DarkColors.white : LightColors.primeColor,
    //   fontSize: 16,
    //   fontWeight: FontWeight.w600,
    // ),
    this.prefixColor = Colors.white54,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return TextFormField(
      focusNode: focusNode,
      onTap: onTap,
      maxLines: 1,
      style: TextStyle(
        color: context.isDarkMode ? DarkColors.white : LightColors.mainText,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      maxLength: maxLength,
      inputFormatters: [DigitPersianFormatter()],
      onFieldSubmitted: onSubmit,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
        counterText: "",
        hintStyle: AppTextStyles.base(
            fontSize: 16,
            color: context.isDarkMode ? DarkColors.hintText : LightColors.hintText,
            fontWeight: FontWeight.w400,
            context: context
        ),
        disabledBorder: InputBorder.none,
        // errorStyle: const TextStyle(height: 0.1, fontSize: 13),
        hintMaxLines: 1,
        contentPadding: contentPadding,
        // prefixIcon: Icon(
        //   prefixIcon,
        //   color: prefixColor,
        //   size: 0,
        // ),
        suffixIcon: suffixIcon,
        suffixIconColor: themeData.iconTheme.color,
        hintText: hintText,
      ),
    );
  }
}

class DigitPersianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String persianInput = newValue.text;
    int selectionIndex = newValue.selection.end;
    return newValue.copyWith(
      text: persianInput.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
