import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/core/utils/navigation/navigation_utils.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Tunggu ya!',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Center(
              child: SvgPicture.asset(
            'assets/images/analisis.svg',
            height: 45.h,
            width: 40.h,
            excludeFromSemantics: true,
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Stack(
                children: [
                  Container(
                    width: 70.w,
                    height: 2.h,
                    decoration: BoxDecoration(
                        color: neutral30,
                        borderRadius: BorderRadius.circular(1.h)),
                  ),
                  Shimmer(
                      color: Colors.white,
                      direction: ShimmerDirection.fromLeftToRight(),
                      colorOpacity: 0.5,
                      child: Container(
                        width: 50.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(1.h)),
                      )),
                ],
              )),
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.h),
            child: Text(
              'Pandan lagi menilai kondisi kesehatan kamu. Panda juga akan carikan program yang terbaik untuk kamu tentunya',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, color: neutral90, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
