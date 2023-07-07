import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../home/theme.dart';
import '../../widgets/input_costume.dart';

class SurveyAkun extends StatefulWidget {
  const SurveyAkun({Key? key}) : super(key: key);

  @override
  State<SurveyAkun> createState() => _SurveyAkunState();
}

class _SurveyAkunState extends State<SurveyAkun> {
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib diisi ya'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib diisi ya'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter ya'),
  ]);
  @override
  Widget build(BuildContext context) {
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
                          'Terakhir nih, Pandan akan buatkan akun kamu',
                          textStyle: GoogleFonts.poppins())
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomFormField(
                hintText: 'Misal: pandan@mail.com',
                state: email!,
                labelText: 'Masukkan email kamu di sini',
                inputType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomFormField(
                  hintText: 'Password',
                  state: password!,
                  labelText: 'Buat password akun kamu',
                  isSecure: true,
                  validator: passwordValidator),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        )
      ],
    );
  }
}
