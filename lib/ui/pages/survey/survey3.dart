import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';

import '../../../core/viewmodels/survey/surveyProvider.dart';

class Survey3 extends StatefulWidget {
  const Survey3({Key? key}) : super(key: key);

  @override
  State<Survey3> createState() => _Survey3State();
}

class _Survey3State extends State<Survey3> {
  // Gender _selected = Gender.Pria;

  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<SurveyProvider>(context);

    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/p_face.svg',
              width: 8.h,
              height: 8.h,
            ),
            SizedBox(
              width: 2.h,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    border: Border.all(color: neutral60),
                    borderRadius: BorderRadius.circular(1.h)),
                child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    pause: Duration(milliseconds: 3000),
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Apa tujuan kamu pakai aplikasi ini?',
                          textStyle: GoogleFonts.poppins())
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              survey.tujuan = "Menaikkan berat badan";
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
            decoration: BoxDecoration(
                color: neutral30,
                borderRadius: BorderRadius.circular(defMargin),
                border: survey.tujuan == "Menaikkan berat badan"
                    ? Border.all(color: primaryDarkColor)
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/barbel.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                  child: Text(
                    'Menaikkan berat badan',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: blackColor),
                  ),
                ),
                Radio(
                    value: "Menaikkan berat badan",
                    groupValue: survey.tujuan,
                    activeColor: primaryDarkColor,
                    onChanged: ((value) {
                      setState(() {
                        survey.tujuan = "Menaikkan berat badan";
                      });
                    }))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              survey.tujuan = "Menurunkan berat badan";
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
            decoration: BoxDecoration(
                color: neutral30,
                borderRadius: BorderRadius.circular(defMargin),
                border: survey.tujuan == "Menurunkan berat badan"
                    ? Border.all(color: primaryDarkColor)
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/apple.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                    child: Text(
                  'Menurunkan berat badan',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: blackColor),
                )),
                Radio(
                    value: "Menurunkan berat badan",
                    groupValue: survey.tujuan,
                    activeColor: primaryDarkColor,
                    onChanged: ((value) {
                      setState(() {
                        survey.tujuan = "Menurunkan berat badan";
                      });
                    }))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              survey.tujuan = "Mempertahankan berat badan";
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
            decoration: BoxDecoration(
                color: neutral30,
                borderRadius: BorderRadius.circular(defMargin),
                border: survey.tujuan == "Mempertahankan berat badan"
                    ? Border.all(color: primaryDarkColor)
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/balance.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                    child: Text(
                  'Mempertahankan berat badan',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: blackColor),
                )),
                Radio(
                    value: "Mempertahankan berat badan",
                    groupValue: survey.tujuan,
                    activeColor: primaryDarkColor,
                    onChanged: ((value) {
                      setState(() {
                        survey.tujuan = "Mempertahankan berat badan";
                      });
                    }))
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(children: [
            Icon(
              Icons.info_outline,
              color: primaryDarkColor,
            ),
            SizedBox(
              width: 2.h,
            ),
            Expanded(
              child: Text(
                'Yuk, ceritakan tujuan kamu pakai aplikasi ini! Apakah ingin menurunkan berat badan, menambah massa otot, atau menjaga berat badan ?',
                softWrap: true,
                textAlign: TextAlign.start,
                style: normalText.copyWith(
                  fontSize: 12,
                  color: Color(0xff707070),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }
}
