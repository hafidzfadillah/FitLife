import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/viewmodels/survey/surveyProvider.dart';
import '../../home/theme.dart';
import '../../widgets/input_costume.dart';

class SurveyNama extends StatefulWidget {
  const SurveyNama({Key? key}) : super(key: key);

  @override
  State<SurveyNama> createState() => _SurveyNamaState();
}

class _SurveyNamaState extends State<SurveyNama> {
  final nameValidator = RequiredValidator(errorText: 'Nama wajib diisi ya');

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
                      TypewriterAnimatedText('Aku Pandan, siapa nama kamu?',
                          textStyle: GoogleFonts.poppins())
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        CustomFormField(
          hintText: 'Misal: Pandan',
          labelText: 'Masukkan nama kamu di sini',
          state: name!,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r"[a-zA-Z]+|\s"),
            )
          ],
          validator: nameValidator,
        ),
      ],
    );
  }
}
