import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/core/models/survey/survey_model.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/weight_indicator.dart';

import '../../widgets/button.dart';

class SurveyResultScreen extends StatelessWidget {
  static const routeName = "/result-survey";
  final SurveyModel? result;

  const SurveyResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    print(result!.dailyCalories);
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Hasil Penilaian',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(defMargin),
                children: [
                  Text(
                    'Index Massa Tubuh (IMT)',
                    style: GoogleFonts.poppins(
                        fontSize: subheaderSize, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  WeightIndicator(
                      bmi: result!.bmi, label: result!.bmiClassification),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/p_face.svg',
                        width: 8.h,
                        height: 8.h,
                      ),
                      SizedBox(
                        width: defMargin,
                      ),
                      Container(
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: neutral60),
                            borderRadius: BorderRadius.circular(1.h)),
                        child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            pause: Duration(milliseconds: 3000),
                            animatedTexts: [
                              TypewriterAnimatedText('${result!.warning}',
                                  textStyle: GoogleFonts.poppins())
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Penilaian Kesehatanmu',
                    style: GoogleFonts.poppins(
                        fontSize: subheaderSize, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defRadius),
                            color: Color(0xFFEF7B0F).withOpacity(0.2)),
                        child: Image.asset(
                          'assets/images/calories.png',
                        ),
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kebutuhan Kalori',
                            style: GoogleFonts.poppins(),
                          ),
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '${result!.dailyCalories}',
                                  style: GoogleFonts.poppins(
                                      color: blackColor,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: ' kcal / day',
                                      style: GoogleFonts.poppins(
                                        color: neutral60,
                                        fontSize: captionSize,
                                      ),
                                    )
                                  ])),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defRadius),
                            color: Color(0xFF8D5EBC).withOpacity(0.2)),
                        child: Image.asset(
                          'assets/images/monitor_weight.png',
                        ),
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rekomendasi berat badan',
                            style: GoogleFonts.poppins(),
                          ),
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '${result!.recommendedWeight}kg',
                                  style: GoogleFonts.poppins(
                                      color: blackColor,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text:
                                          ' (Berat badan kamu: ${result!.idealWeight.round()}kg)',
                                      style: GoogleFonts.poppins(
                                        color: neutral60,
                                        fontSize: captionSize,
                                      ),
                                    )
                                  ])),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defRadius),
                            color: Color(0xFF89E0FC).withOpacity(0.2)),
                        child: Image.asset(
                          'assets/images/flow_arrow.png',
                        ),
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rekomendasi berat badan',
                            style: GoogleFonts.poppins(),
                          ),
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: '${result!.programs!.programName}',
                                  style: GoogleFonts.poppins(
                                      color: blackColor,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    // TextSpan(
                                    //   text: ' (Berat badan kamu: ${result.idealWeight.round()}kg)',
                                    //   style: GoogleFonts.poppins(
                                    //       color: neutral60,
                                    //       fontSize: captionSize,),

                                    // )
                                  ])),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defMargin),
              child: RoundedButton(
                width: double.infinity,
                title: "Lanjut",
                style: GoogleFonts.poppins(color: Colors.white),
                background: primaryColor,
                onClick: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            )
          ],
        ));
  }
}
