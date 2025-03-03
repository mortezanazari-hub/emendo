import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/assets.dart';
import 'package:emendo/features/home/presentations/screen/home_screen.dart';
import 'package:emendo/features/home/presentations/widgets/bottom_nav_bar/main_icon.dart';
import 'package:emendo/features/home/presentations/widgets/bottom_nav_bar/svg_icons.dart';
import 'package:emendo/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/bottom_nav_cubit.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final List bottomTab = [
    SvgIcons(asset: Assets.homeTab),
    SvgIcons(asset: Assets.folderTab),
    MainIcon(),
    SvgIcons(asset: Assets.notificationTab),
    SvgIcons(asset: Assets.profileTab),
  ];
  final List activeBottomTab = [
    SvgIcons(asset: Assets.homeTab,isActive: true,),
    SvgIcons(asset: Assets.folderTab,isActive: true,),
    MainIcon(),
    SvgIcons(asset: Assets.notificationTab,isActive: true,),
    SvgIcons(asset: Assets.profileTab,isActive: true,),
  ];
  final List<Widget> bottomNavScreens =  [
    HomeScreen(),
    const FolderScreen(),
    const ChatScreen(),
    const ProfileScreen()
  ];
  late final PageController pageController;


  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: const ClampingScrollPhysics(),
          onPageChanged: (value) {
            context.read<BottomNavCubit>().changeIndex(value);
          },
          controller: pageController,
          children: bottomNavScreens
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit,int>(
        builder: (context, state) {
          return BottomNavigationBar(
              backgroundColor: context.isDarkMode ? DarkColors.buttonBarBackColor : LightColors.buttonBarBackColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                context.read<BottomNavCubit>().changeIndex(value);
                pageController.jumpToPage(value);
              },
              currentIndex: state,
              items: List.generate(
                bottomTab.length,
                  (index) => BottomNavigationBarItem(
                  activeIcon: activeBottomTab[index],
                  icon: bottomTab[index],
                  label: ''
                ),
              )
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
