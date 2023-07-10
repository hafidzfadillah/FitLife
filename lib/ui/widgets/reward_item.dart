import 'package:fitlife/core/models/checkin/checkin_model.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RewardItem extends StatelessWidget {
  final CheckinModel model;
  final int index;

  const RewardItem({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.h),
          border: Border.all(
              width: 2,
              color: model.loginDate ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())
                  ? primaryColor
                  : neutral30)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                model.rewardReceived == 1 ||
                        model.loginDate !=
                            DateFormat('yyyy-MM-dd').format(DateTime.now())
                    ? 'assets/images/claimed_coin.svg'
                    : 'assets/images/badge_coin.svg',
                width: 4.h,
                height: 4.h,
              ),
              model.rewardReceived == 1
                  ? Icon(
                      Icons.check,
                      color: neutral70,
                      size: 20,
                    )
                  : Text('${model.rewardValue}')
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Day $index',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
