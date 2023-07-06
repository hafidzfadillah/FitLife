import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';

import '../../../core/viewmodels/survey/surveyProvider.dart';

class Survey1 extends StatefulWidget {
  @override
  State<Survey1> createState() => _Survey1State();
}

class _Survey1State extends State<Survey1> {
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
                      TypewriterAnimatedText('Apa jenis kelamin kamu?',
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
            // setState(() {
            survey.gender = Gender.Pria;
            // });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
            decoration: BoxDecoration(
                color: neutral30,
                borderRadius: BorderRadius.circular(defMargin),
                border: survey.gender == Gender.Pria
                    ? Border.all(color: primaryDarkColor)
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/boy.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                  child: Text(
                    'Laki-laki',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: blackColor),
                  ),
                ),
                Radio(
                    value: Gender.Pria,
                    groupValue: survey.gender,
                    activeColor: primaryDarkColor,
                    onChanged: ((value) {
                      // setState(() {
                      survey.gender = Gender.Pria;
                      // });
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
            // setState(() {
            survey.gender = Gender.Wanita;
            // });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
            decoration: BoxDecoration(
                color: neutral30,
                borderRadius: BorderRadius.circular(defMargin),
                border: survey.gender == Gender.Wanita
                    ? Border.all(color: primaryDarkColor)
                    : null),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/girl.svg',
                  width: 3.h,
                  height: 3.h,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Expanded(
                  child: Text(
                    'Perempuan',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: blackColor),
                  ),
                ),
                Radio(
                    value: Gender.Wanita,
                    groupValue: survey.gender,
                    activeColor: primaryDarkColor,
                    onChanged: ((value) {
                      // setState(() {
                      survey.gender = Gender.Wanita;
                      // });
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
                'Dengan tahu jenis kelaminmu, Pandan bisa menghitung seberapa cepat tubuhmu membakar energi. Jadi nanti program yang aku kasih bisa sesuai banget dengan kebutuhanmu!',
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
