import 'dart:math';
import 'package:emendo/common/helper/is_rtl_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/configs/Assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final Widget? leadingWidget;
  final Widget? actionButton;
  final Color? backGroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.leadingWidget,
    this.actionButton,
    this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: AppBar(
        centerTitle: true,
        title: title ?? const Text(''),
        backgroundColor: backGroundColor ?? Colors.transparent,
        foregroundColor: backGroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: leadingWidget ?? IconButton(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: LightColors.outLineBorder),
              color: Colors.white
            ),
            // child: SvgPicture.asset(context.isDarkMode ? Assets.backButtonLight : Assets.backButtonDark,fit: BoxFit.none,),
            child: context.isRtl
                ? Transform.rotate(angle: pi ,child: backButton(),)
                : backButton()
          ),
        ),
      ),
    );
  }

  Widget backButton(){
    return SvgPicture.asset(Assets.backButtonDark,fit: BoxFit.none,);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}


