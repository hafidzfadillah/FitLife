import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/core/utils/navigation/navigation_utils.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';

class MainTopBar extends StatefulWidget {
  const MainTopBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MainTopBar> createState() => _MainTopBarState();
}

class _MainTopBarState extends State<MainTopBar> {
  // void initState
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userData = userProvider.user;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: defMargin, vertical: 0.5.h),
              decoration: BoxDecoration(
                  border: Border.all(color: neutral30),
                  borderRadius: BorderRadius.circular(defMargin)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                  SizedBox(
                    width: 1.h,
                  ),
                  Text(
                    '${userData?.point.toString() ?? '0'} poin • Level  1',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Image.asset(
              'assets/images/gg_bot.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/chatbot');
            },
            color: Color(0xff333333),
          ),
          SizedBox(
            width: 2.h,
          ),
          InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/profile');
              },
              child: Icon(Icons.menu, color: Color(0xff333333))),
        ],
      ),
    );
  }
}

class MainTopBar2 extends StatefulWidget {
  const MainTopBar2({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainTopBar2> createState() => _MainTopBar2State();
}

class _MainTopBar2State extends State<MainTopBar2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(width: 2.h,),
          InkWell(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/coin.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  '100',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.amber,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 3.h,
                ),
                SvgPicture.asset(
                  'assets/images/bamboo.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  '100',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
