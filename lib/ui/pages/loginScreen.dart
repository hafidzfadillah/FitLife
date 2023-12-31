import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/survey/loadingScreen.dart';
import 'package:fitlife/ui/widgets/button.dart';

import '../widgets/input_costume.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");
  bool isLoading = false;

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib di isi ya'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib di isi ya'),
  ]);
  final _formKey = GlobalKey<FormState>();

  final UserProvider _userProvider = UserProvider();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Mohon tunggu');
      try {
        bool response = await _userProvider.login(email!.text, password!.text);

        if (response == true) {
          EasyLoading.showSuccess('Selamat datang kembali!');
          Navigator.pushNamedAndRemoveUntil(context, '/home',  (route) => false);
        } else {
          EasyLoading.showError('Email atau password salah');
        }
      } catch (error) {
        // handle error here

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CustomBackButton(
              iconColor:  Color(0xff707070),
              onClick: () {
                Navigator.pop(context);
              },
            )),
        body: SafeArea(
            child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 28),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text('Selamat datang kembali, sobat!',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff707070))),
                    SizedBox(
                      height: 4.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFormField(
                            hintText: 'Masukkan email kamu',
                            state: email!,
                            labelText: 'Email',
                            inputType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomFormField(
                              hintText: 'Masukkan password',
                              state: password!,
                              labelText: 'Password',
                              isSecure: true,
                              validator: passwordValidator),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Lupa password?",
                                style: secondaryText.copyWith(
                                    fontSize: captionSize,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RoundedButton(
                            title: 'Masuk',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                            background: primaryColor,
                            onClick: () {
                              _handleLogin();
                            },
                            width: double.infinity,
                            height: 54,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    text: 'Belum punya akun? ',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 14),
                                    children: [
                                  TextSpan(
                                    text: 'Buat sekarang',
                                    style: GoogleFonts.poppins(
                                        color: primaryDarkColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        EasyLoading.show(
                                          status: 'Pandan siap-siap dulu..',
                                        );
                                        Timer(Duration(seconds: 2), () {
                                          EasyLoading.dismiss();
                                          Navigator.pushNamed(
                                              context, '/survey');
                                        });
                                      },
                                  )
                                ])),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black54,
                child: Center(child: LoadingScreen()),
              ),
            )
          ],
        )),
      );
    });
  }
}
