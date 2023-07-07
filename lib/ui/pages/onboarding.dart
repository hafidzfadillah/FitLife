import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/global/cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';
import 'package:fitlife/ui/widgets/button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isAuth = false;

  @override
  void initState() {
    // TODO: implement initState
    _checkIfLoggedIn();

    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString('access_token') ?? '0';
    print('onboarding $token');
    if (token != null && token != '0') {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

      }
    }
  }

  List<Widget> generateCustomTabs() {
    return List.generate(
        2,
        (index) => Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: neutral60),
                        borderRadius: BorderRadius.circular(1.h)),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        pause: Duration(seconds: 2000),
                        animatedTexts: [
                          TypewriterAnimatedText(
                              onboardMap[index]['title'] ?? 'title',
                              textStyle: GoogleFonts.poppins())
                        ]),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SvgPicture.asset(
                    'assets/images/onboard_${index + 1}.svg',
                    height: 35.h,
                    width: 30.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child: Text(
                      onboardMap[index]['desc'] ?? 'desc',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(),
                    ),
                  ))
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
                child: IntroSlider(
              listCustomTabs: generateCustomTabs(),
              isShowSkipBtn: false,
              isShowNextBtn: false,
              isShowPrevBtn: false,
              isShowDoneBtn: false,
            )),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defMargin, vertical: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedButton(
                      width: double.infinity,
                      title: 'Mulai hidup sehat',
                      style: GoogleFonts.poppins(color: Colors.black),
                      background: primaryColor,
                      onClick: () {
                        EasyLoading.show(
                          status: 'Pandan siap-siap dulu..',
                        );
                        Timer(Duration(seconds: 2), () {
                          EasyLoading.dismiss();
                          Navigator.pushNamed(context, '/survey');
                        });
                      }),
                  SizedBox(
                    height: 2.h,
                  ),
                  RoundedOutlineButton(
                      color: Colors.grey,
                      width: double.infinity,
                      title: 'Saya telah mempunyai akun',
                      style: GoogleFonts.poppins(color: blackColor),
                      onClick: () {
                        Navigator.pushNamed(context, '/login');
                      }),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
