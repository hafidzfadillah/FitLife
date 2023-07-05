import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/global/cons.dart';
import 'package:flutter/material.dart';
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
    var token = localStorage.getString('access_token');
    print('onboarding $token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

        // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
                    style: textRegularStyle ,
                    textAlign: TextAlign.center,
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
        
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defMargin, vertical: 2.h),
          child: Column(
            children: [
              Expanded(
                  child: IntroSlider(
                listCustomTabs: generateCustomTabs(),
                isShowSkipBtn: false,
                isShowNextBtn: false,
                isShowPrevBtn: false,
                isShowDoneBtn: false,
              )),


             RoundedButton(
                  width: double.infinity,
                  title: 'Terobos',
                  style: GoogleFonts.poppins(color: Colors.black),
                  background: Colors.red,
                  onClick: () {
                    Navigator.pushNamed(context, '/leadeboard');
                  }),
               Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedButton(
                        width: double.infinity,
                        title: 'Mulai hidup sehat',
                        style: GoogleFonts.poppins(color: Colors.black),
                        background: primaryColor,
                        onClick: () {
                          Navigator.pushNamed(context, '/register');
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    RoundedOutlineButton(
                        color: Colors.grey,
                        width: double.infinity,
                        title: 'Saya telah mempunyai akun',
                        style: GoogleFonts.poppins(color: Colors.black),
                        onClick: () {
                          Navigator.pushNamed(context, '/login');
                        }),
                  ],
                ),
            
            ],
          ),
        ),
      );
    });
  }
}
