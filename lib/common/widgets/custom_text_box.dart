import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextBox extends StatelessWidget {
  final TextEditingController textEditingController;
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
  final TextStyle hintStyle;
  final Color prefixColor;
  final TextStyle style;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;

  CustomTextBox({
    super.key,
    this.onTap,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.number,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.validator,
    required this.onSubmit,
    this.onEditingComplete,
    this.isNumber = false,
    this.maxLength,
    this.focusNode,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    this.hintStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    this.style = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    this.prefixColor = Colors.white54,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return TextFormField(
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      onTap: onTap,
      maxLines: 1,
      style: style,
      maxLength: maxLength,
      inputFormatters: [digitPersianFormatter()],
      onFieldSubmitted: onSubmit,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
        counterText: "",
        hintStyle: hintStyle,
        disabledBorder: InputBorder.none,
        errorStyle: const TextStyle(height: 0.1, fontSize: 13),
        hintMaxLines: 1,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixColor,
          size: 25,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: themeData.iconTheme.color,
        hintText: hintText,
      ),
    );
  }
}

class digitPersianFormatter extends TextInputFormatter {
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
