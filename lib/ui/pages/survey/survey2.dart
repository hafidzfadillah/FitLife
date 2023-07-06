import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';

import '../../../core/viewmodels/survey/surveyProvider.dart';
import '../../home/theme.dart';

class Survey2 extends StatefulWidget {
  const Survey2({Key? key}) : super(key: key);

  @override
  State<Survey2> createState() => _Survey2State();
}

class _Survey2State extends State<Survey2> {
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
                      TypewriterAnimatedText('Berapa tahun umur kamu?',
                          textStyle: GoogleFonts.poppins())
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPicker(
              haptics: true,
              textStyle: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.w500, color: neutral60),
              selectedTextStyle: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: primaryDarkColor),
              value: survey.umur,
              minValue: 1,
              maxValue: 99,
              onChanged: (value) => setState(() => survey.umur = value),
            ),
            Text(
              'tahun',
              style: GoogleFonts.poppins(fontSize: 20, color: blackColor),
            )
          ],
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
                'Pandan bisa tahu seberapa cepat tubuhmu membakar energi loh. Nah, dengan tahu umur kamu, program yang Pandan kasih nanti bisa banget sesuai dengan kebutuhanmu!',
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
