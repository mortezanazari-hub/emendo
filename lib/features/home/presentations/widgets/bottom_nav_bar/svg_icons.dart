import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcons extends StatelessWidget {
  final String asset;
  final bool isActive;
  const SvgIcons({
    super.key,
    required this.asset,
    this.isActive = false
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      color: isActive ? context.isDarkMode ? DarkColors.primeColor : LightColors.primeColor : null,
    );
  }
}
