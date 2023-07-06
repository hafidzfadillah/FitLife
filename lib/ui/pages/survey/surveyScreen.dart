import 'package:fitlife/ui/pages/survey/surveyAkun.dart';
import 'package:fitlife/ui/pages/survey/surveyIntro.dart';
import 'package:fitlife/ui/pages/survey/surveyNama.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/survey/loadingScreen.dart';
import 'package:fitlife/ui/pages/survey/survey1.dart';
import 'package:fitlife/ui/pages/survey/survey2.dart';
import 'package:fitlife/ui/pages/survey/survey3.dart';
import 'package:fitlife/ui/pages/survey/survey4.dart';
import 'package:fitlife/ui/pages/survey/survey5.dart';
import 'package:fitlife/ui/pages/survey/survey6.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/navigation/navigation_utils.dart';
import '../../../core/viewmodels/survey/surveyProvider.dart';
import '../../../core/viewmodels/user/user_provider.dart';

TextEditingController? name = TextEditingController(text: "");
TextEditingController? email = TextEditingController(text: "");
TextEditingController? password = TextEditingController(text: "");

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  double percentage = 1 / 9;
  int currentPage = 0;

  bool isLoading = false;

  SurveyProvider survey = SurveyProvider();

  List<Widget> _screens = [
    SurveyIntro(),
    SurveyNama(),
    Survey1(),
    Survey2(),
    Survey3(),
    Survey4(),
    Survey5(),
    Survey6(),
    SurveyAkun()
  ];

  final UserProvider _userProvider = UserProvider();

  Future<void> _handleDaftar() async {
    // if (_formKey.currentState!.validate()) {
    EasyLoading.show(status: 'Pandan lagi buatkan akunmu');
    try {
      bool response =
          await _userProvider.daftar(name!.text, email!.text, password!.text);

      if (response == true) {
        EasyLoading.showToast('Akun berhasil dibuat');
        _storeSurvey();
      } else {
        EasyLoading.showError('Akun gagal dibuat');
      }
    } catch (error) {
      // handle error here
      if (!EasyLoading.isShow) {
        EasyLoading.showToast('Akun berhasil dibuat');
      }

      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    // }
  }

  Future<void> _storeSurvey() async {
    try {
      setState(() {
        isLoading = true;
      });
      var rsp = await survey.store();
      print("result final : ${rsp!.dailyCalories}");
      setState(() {
        isLoading = false;
      });

      if (rsp != null) {
        Navigator.pushReplacementNamed(context, '/result-survey',
            arguments: rsp);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => survey,
      child: WillPopScope(
        onWillPop: () async {
          setState(() {
            name!.clear();
            email!.clear();
            password!.clear();
          });
          // survey.dispose();
          return true;
        },
        child: Scaffold(
            body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildTopbar(context),
                    Expanded(child: _screens[currentPage]),
                    RoundedButton(
                      width: double.infinity,
                      background: primaryColor,
                      title: 'Lanjut',
                      style: GoogleFonts.poppins(
                        color: blackColor,
                      ),
                      onClick: () {
                        if (percentage == 9 / 9 || currentPage == 8) {
                          print('survey done');
                          if (email!.text.isEmpty || password!.text.isEmpty) {
                            EasyLoading.showToast(
                                'Oops.. Email atau password tidak boleh kosong ya');
                            return;
                          }
                          // survey.result();
                          _handleDaftar();
                        } else {
                          if (currentPage == 1 && name!.text.isEmpty) {
                            EasyLoading.showToast(
                                'Oops.. Nama tidak boleh kosong ya');
                            return;
                          }
                          print(name!.text);
                          setState(() {
                            percentage += 1 / 9;
                            currentPage += 1;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.white,
                  child: Center(child: LoadingScreen()),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildTopbar(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          CustomBackButton(
            iconColor: primaryColor,
            onClick: () {
              if (percentage <= 1 / 9 || currentPage == 0) {
                Navigator.pop(context);
              } else {
                setState(() {
                  percentage -= 1 / 9;
                  currentPage -= 1;
                });
              }
            },
          ),
          Expanded(
              child: Center(
            child: Container(
              height: defMargin,
              child: LinearPercentIndicator(
                width: 30.w,
                lineHeight: 1.h,
                barRadius: Radius.circular(4),
                percent: percentage > 1 ? 1 : percentage,
                backgroundColor: neutral30,
                progressColor: primaryColor,
                alignment: MainAxisAlignment.center,
              ),
            ),
          )),
          InkWell(
            onTap: () {
              // Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Lewati',
              style: subtitleTextStyle2.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.transparent),
            ),
          )
        ],
      ),
    );
  }
}
