import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainIcon extends StatelessWidget {
  const MainIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: LightColors.bottomBarIconShadowColor,
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 3), // Moves shadow downward
                ),
              ]
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:context.isDarkMode ? DarkColors.primeColor : LightColors.primeColor,
          ),
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white
          ),
        )
      ],
    );
  }
}
