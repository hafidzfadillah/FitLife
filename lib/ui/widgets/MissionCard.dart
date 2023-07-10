import 'dart:math';

import 'package:fitlife/global/cons.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/mission_progress_circural_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({
    Key? key,
    required this.progress,
    this.missionColor,
    required this.title,
    required this.target,
    required this.current,
    required this.pointReward,
    required this.unit,
    required this.icon,
    this.backgroundColor,
    required this.screen,
    required this.route,
  }) : super(key: key);

  final double progress;
  final String? missionColor;
  final String title;
  final int target;
  final int current;
  final int pointReward;
  final String unit;
  final String icon;
  final String? backgroundColor;
  final String screen;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(route.toLowerCase());
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: 3 * pi / 4,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Color(int.parse(missionColor ?? '7FB06B'))),
                        value: progress / 100,
                        strokeWidth: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 42,
                      ),
                    ),
                    CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Image.asset(
                            'assets/images/$icon',
                            width: 5.h,
                            height: 5.h,
                            errorBuilder: (context, error, stackTrace) {
                              return Container();
                            },
                          ),
                        ),
                        radius: 35,
                        backgroundColor:
                            Color(int.parse(missionColor ?? '7FB06B'))
                        // HexColor.fromHex(missionColor ?? "#7FB06B"),
                        )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/images/badge_coin.svg'),
                    Text(
                      pointReward.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );

    // return InkWell(
    //   onTap: () {

    //   },
    //   child: Container(
    //     padding: EdgeInsets.all(16),
    //     margin: EdgeInsets.only(bottom: 10),
    //     decoration: BoxDecoration(
    //       color: Color(0xffF6F8FA),
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Row(
    //       children: [
    //         MissionProgressCircuralBar(
    //           progress: progress ?? 0.0,
    //           size: 40,
    //           backgroundColor: Color(
    //             backgroundColor ?? 0xffF6F8FA,
    //           ),
    //           foregroundColor: Color(missionColor ?? 0xff0BB576),
    //           strokeWidth: 8,
    //           assetName: icon,
    //         ),
    //         SizedBox(
    //           width: 15,
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               style: normalText.copyWith(
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w700,
    //                 color: Color(0xff333333),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text(
    //               target == 0
    //                   ? current == 0
    //                       ? '-' + ' ' + unit
    //                       : current.toString() + ' ' + unit
    //                   : current.toString() +
    //                       "/" +
    //                       target.toString() +
    //                       " " +
    //                       unit,
    //               style: normalText.copyWith(
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //                 color: Color(0xff333333),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Icon(Icons.star, color: Colors.yellow[700], size: 16),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text(
    //                   pointReward.toString() + " poin",
    //                   style: normalText.copyWith(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w400,
    //                     color: Color(0xff333333),
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    print(hexString);
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
