import 'package:fitlife/ui/pages/topup_bamboo_screen.dart';
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
    this.title = '',
  }) : super(key: key);

  final String title;
  @override
  State<MainTopBar> createState() => _MainTopBarState();
}

class _MainTopBarState extends State<MainTopBar> {
  // void initState
  @override
  void initState() {
    // super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final userProvider = Provider.of<UserProvider>(context, listen: false);
    //   userProvider.getUserData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E2E0),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: defMargin, vertical: 7),
      child: Row(
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333)),
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/images/coin.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {},
                color: Color(0xff333333),
              ),
              Text(
                110.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFCD00)),
              )
            ],
          ),
          SizedBox(
            width: 2.h,
          ),
          Row(
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/images/bamboo.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {},
                color: Color(0xff333333),
              ),
              Text(
                50.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff00C680)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MainTopBar2 extends StatefulWidget {
  const MainTopBar2({Key? key}) : super(key: key);

  @override
  State<MainTopBar2> createState() => _MainTopBar2State();
}

class _MainTopBar2State extends State<MainTopBar2> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Hi, ${userProvider.user?.name ?? 'Sobat'}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: ((context) => TopUpBambooScreen())));
            },
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
                  '${userProvider.user?.coin}',
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
                  '${userProvider.user?.bamboo}',
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
