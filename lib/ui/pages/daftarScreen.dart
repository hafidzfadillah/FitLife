import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/navigation/navigation_utils.dart';
import 'package:fitlife/ui/pages/survey/loadingScreen.dart';
import 'package:fitlife/ui/pages/survey/surveyScreen.dart';

import '../../core/viewmodels/user/user_provider.dart';
import '../home/theme.dart';
import '../widgets/button.dart';
import '../widgets/input_costume.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController? name = TextEditingController(text: "");
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");

  final nameValidator = RequiredValidator(errorText: 'Nama wajib diisi');

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib diisi ya'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib diisi ya'),
    MinLengthValidator(8, errorText: 'Password minimal 8 karakter ya'),
  ]);

  final UserProvider _userProvider = UserProvider();

  Future<void> _handleDaftar() async {
    // if (_formKey.currentState!.validate()) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   try {
    //     bool response =
    //         await _userProvider.daftar(name!.text, email!.text, password!.text);

    //     isLoading = false;
    //     if (response == true) {
          Navigator.pushReplacementNamed(context, '/survey');
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Terjadi kesalahan.'),
      //         backgroundColor: Colors.red,
      //       ),
      //     );
      //   }
      // } catch (error) {
      //   // handle error here
      //   print(error);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Terjadi kesalahan.'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
    // }
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
                      'Buat Akun',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Mulai hidup sehat bersama Fitlife',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFormField(
                            hintText: 'Masukkan nama kamu',
                            labelText: 'Nama',
                            state: name!,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z]+|\s"),
                              )
                            ],
                            validator: nameValidator,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
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
                            height: 4.h,
                          ),
                          RoundedButton(
                              width: double.infinity,
                              title: 'Buat Akun',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                              ),
                              background: primaryColor,
                              height: 54,
                              onClick: () {
                                _handleDaftar();
                              }),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    text: 'Sudah punya akun? ',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 14),
                                    children: [
                                  TextSpan(
                                    text: 'Masuk',
                                    style: GoogleFonts.poppins(
                                        color: primaryDarkColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, '/login');
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
