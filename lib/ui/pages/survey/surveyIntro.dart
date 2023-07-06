import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SurveyIntro extends StatelessWidget {
  const SurveyIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/scooter.svg',
          height: 45.h,
          width: 40.w,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 5.h,
        ),
        Consumer<UserProvider>(builder: (context, userProv, _) {
          return Text(
            'Halo, ${getName(userProv.user?.name ?? 'sobat')}! Sebelum mulai, Pandan mau kenal lebih jauh dong sama kamu',
            style: GoogleFonts.poppins(color: Colors.black),
            textAlign: TextAlign.center,
          );
        })
      ],
    );
  }

  String getName(String name) {
    if (name.contains(" ")) {
      final splitted = name.split(" ");
      return splitted.first;
    }

    return name;
  }
}
