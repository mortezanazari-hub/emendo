import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final bool checked;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox(
    this.checked, {
    super.key,
    required this.onChanged,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _checked;

  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.2,
            color: context.isDarkMode
                ? DarkColors.activeBorder
                : LightColors.activeBorder,
          )),
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          setState(() {
            _checked = !_checked;
            widget.onChanged(_checked);
          });
        },
        child: SizedBox(
          width: 25,
          height: 25,
          child: _checked
              ? Icon(
                  Icons.check,
                  color: context.isDarkMode
                      ? DarkColors.primeColor
                      : LightColors.primeColor,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
