import 'package:fitlife/ui/pages/leaderboard_screen.dart';
import 'package:fitlife/ui/pages/profileScreen.dart';
import 'package:fitlife/ui/pages/shop_screen.dart';
import 'package:fitlife/ui/pages/shorts_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/home_screen.dart';
import 'package:fitlife/ui/pages/article_screen.dart';
import 'package:fitlife/ui/pages/chat_bot.dart';
import 'package:fitlife/ui/pages/vita_mart.dart';
import 'package:fitlife/ui/pages/programScreen.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentPage = 0;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      title: 'Home',
      activeColorPrimary: primaryDarkColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.video_library),
      title: 'Reels',
      activeColorPrimary: primaryDarkColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.storefront),
      title: 'Shop',
      activeColorPrimary: primaryDarkColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.leaderboard),
      title: 'Leaderboard',
      activeColorPrimary: primaryDarkColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.badge),
      title: 'Profil',
      activeColorPrimary: primaryDarkColor,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      items: _items,
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
          NavBarStyle.style3, // Choose the nav bar style with this property.
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
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
