import 'package:emendo/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                      "lib/core/resources/images/png/splash_screen_start.png"),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Image.asset(
                      "lib/core/resources/images/png/mini_logo.png",
                      height: 30,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: AppColors.color0,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(0),
                            top: Radius.circular(30),
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
