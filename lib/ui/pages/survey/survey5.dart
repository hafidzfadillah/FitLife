import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';

import '../../../core/viewmodels/survey/surveyProvider.dart';
import '../../home/theme.dart';

class Survey5 extends StatefulWidget {
  const Survey5({Key? key}) : super(key: key);

  @override
  State<Survey5> createState() => _Survey5State();
}

class _Survey5State extends State<Survey5> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<SurveyProvider>(context);
    return Column(children: [
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
                        'Aku yang buncit ini beratnya bisa sampai 135 kg loh. Kalau kamu berapa?',
                        textStyle: GoogleFonts.poppins())
                  ]),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 4.h,
      ),
      FlutterToggleTab(
          width: 20.w,
          isScroll: false,
          labels: ['Kilogram', 'lbs'],
          unSelectedBackgroundColors: [
            Color(0xffF6F8FA),
          ],
          selectedBackgroundColors: [Colors.white],
          selectedLabelIndex: ((p0) {
            setState(() {
              _selected = p0;
            });
            if (_selected == 0) {
              // setState(() {
              survey.weightFormat = WeightFormat.kg;
              // });
            } else {
              // setState(() {
              survey.weightFormat = WeightFormat.lbs;
              // });
            }
          }),
          selectedTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.black),
          unSelectedTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: neutral70),
          selectedIndex: _selected),
      SizedBox(
        height: 4.h,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20.h,
            child: TextFormField(
              initialValue: survey.berat.toString(),
              maxLength: 3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: survey.weightFormat == WeightFormat.kg
                    ? "Berat badan (kg)"
                    : "Berat badan (lbs)",
              ),
              onChanged: (value) {
                // setState(() {
                survey.berat = int.tryParse(value) ?? 0;
                // });
              },
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          Text(survey.weightFormat == WeightFormat.kg ? 'kg' : 'lbs',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
        ],
      )
    ]);
  }
}
