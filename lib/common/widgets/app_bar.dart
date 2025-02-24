import 'dart:math';

import 'package:emendo/common/helper/is_rtl_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/configs/Assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final bool? hideBack;
  final Color? backGroundColor;
  const CustomAppBar({super.key,this.title,this.hideBack = false,this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18,top: 10),
      child: AppBar(
        centerTitle: true,
        title: title ?? const Text(''),
        backgroundColor: backGroundColor ?? Colors.transparent,
        foregroundColor: backGroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: hideBack! ? null : IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Color(0xffE9F1FF)),
              shape: BoxShape.circle,

            ),
            // child: SvgPicture.asset(context.isDarkMode ? Assets.backButtonLight : Assets.backButtonDark,fit: BoxFit.none,),
            child: context.isRtl
                ? Transform.rotate(angle: pi,child: backButton(),)
                : backButton(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
Widget backButton (){
  return SvgPicture.asset(Assets.backButtonDark,fit: BoxFit.none,);
}