import 'package:fitlife/ui/pages/leaderboard_screen.dart';
import 'package:fitlife/ui/pages/profileScreen.dart';
import 'package:fitlife/ui/pages/shop_screen.dart';
import 'package:fitlife/ui/pages/shorts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/home_screen.dart';
import 'package:fitlife/ui/pages/article_screen.dart';
import 'package:fitlife/ui/pages/chat_bot.dart';
import 'package:fitlife/ui/pages/vita_mart.dart';
import 'package:fitlife/ui/pages/programScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentPage = 0;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      controller: _controller,
      decoration: NavBarDecoration(
          adjustScreenBottomPaddingOnCurve: true,
          border: Border(top: BorderSide(color: currentPage == 1 ? neutral90 : neutral30))),
      items: [
        PersistentBottomNavBarItem(
          activeColorPrimary: primaryDarkColor,
          icon: SvgPicture.asset(
            currentPage == 0
                ? 'assets/images/home_active.svg'
                : 'assets/images/home_nonactive.svg',
            width: 4.h,
            height: 4.h,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: primaryDarkColor,
          icon: SvgPicture.asset(
            currentPage == 1
                ? 'assets/images/reel_active.svg'
                : 'assets/images/reel_nonactive.svg',
            width: 4.h,
            height: 4.h,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: primaryDarkColor,
          icon: SvgPicture.asset(
            currentPage == 2
                ? 'assets/images/shop_active.svg'
                : 'assets/images/shop_nonactive.svg',
            width: 4.h,
            height: 4.h,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: primaryDarkColor,
          icon: SvgPicture.asset(
            currentPage == 3
                ? 'assets/images/leaderboard_active.svg'
                : 'assets/images/leaderboard_nonactive.svg',
            width: 4.h,
            height: 4.h,
          ),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: primaryDarkColor,
          icon: SvgPicture.asset(
            currentPage == 5
                ? 'assets/images/profile_active.svg'
                : 'assets/images/profile_nonactive.svg',
            width: 4.h,
            height: 4.h,
          ),
        ),
      ],
      screens: [
        const HomeScreen(),
        // ProgramScreen(),
        ShortsScreen(
          currentPageIndex: currentPage,
        ),
        const ShopScreen(),
        LeaderboardScreen(),
        // ArticleScreen()
        const ProfileScreen()
      ],
      backgroundColor: _controller.index == 1 ? blackColor : Colors.white,
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 200),
      ),
      onItemSelected: ((value) {
        setState(() {
          currentPage = value;
        });
      }),
    );
  }
}
