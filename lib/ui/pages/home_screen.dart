// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CaloriRow.dart';
import 'package:fitlife/ui/widgets/DatePicker.dart';
import 'package:fitlife/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:fitlife/ui/widgets/mission_section.dart';
import 'package:fitlife/ui/widgets/NutrionInfoBox.dart';
import 'package:fitlife/ui/widgets/NutritionBar.dart';
import 'package:fitlife/ui/widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserData();
    userProvider.getMyMission();
    print('trigger');
  }

  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearMyNutrition();
    userProvider.clearMyMission();
    ConnectionProvider.instance(context).setConnection(true);

    userProvider.getUserData();
    userProvider.getMyMission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        body: Consumer2<ConnectionProvider, UserProvider>(
            builder: (context, connectionProv, userProvider, child) {
          if (connectionProv.internetConnected == false) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak Ada Koneksi Internet"),
                  ElevatedButton(
                    onPressed: () => refreshHome(context),
                    child: const Text("Refresh"),
                  )
                ],
              ),
            );
          }

          if (userProvider.currentDay == null && userProvider.onSearch) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return SafeArea(
              child: RefreshIndicator(
            onRefresh: () => refreshHome(context),
            child: Column(
              children: [
                MainTopBar2(),
                Divider(),
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(children: [
                        SvgPicture.asset(
                          'assets/images/calendar.svg',
                          width: 8.h,
                          height: 8.h,
                        ),
                        SizedBox(
                          width: 2.h,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Hari ke-${userProvider.currentDay?.day ?? ''}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                  Text(
                                    'Lihat detail',
                                    style: GoogleFonts.poppins(
                                      color: primaryDarkColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                  '${userProvider.currentDay?.missionSuccessCount ?? 0} dari ${userProvider.currentDay?.missions?.length} misi hari ini selesai'),
                              SizedBox(
                                height: 2.h,
                              ),
                              LinearPercentIndicator(
                                width: 50.w,
                                lineHeight: 1.h,
                                padding: EdgeInsets.all(0),
                                barRadius: Radius.circular(1.h),
                                percent: userProvider.currentDay == null ? 0 : (userProvider
                                        .currentDay!.missionSuccessCount! /
                                    userProvider.currentDay!.missions!.length),
                                backgroundColor: neutral30,
                                progressColor: primaryColor,
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    // DateSelector(
                    //   userProvider: userProvider,
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    UserNutrion(),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyMisssion()
                  ],
                ))
              ],
            ),
          ));
        }));
  }
}

class UserNutrion extends StatelessWidget {
  const UserNutrion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.currentDay == null && !userProvider.onSearch) {
        // userProvider.getNutrion();

        return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Center(child: CircularProgressIndicator()));
      }
      if (userProvider.currentDay == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const CircularProgressIndicator());
      }

      if (userProvider.currentDay == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Tidak ada produk yang ditemukan'),
          ),
        );
      }

      return Column(
        children: [
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text("Kalori tersisa",
          //         style: normalText.copyWith(
          //             fontSize: 14, color: const Color(0xff454545))),
          // const SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //         (userProvider.myNutrition?.calorieLeft ?? 0) < 0
          //             ? "0"
          //             : userProvider.myNutrition?.calorieLeft.toString() ??
          //                 "",
          //         style: normalText.copyWith(
          //             fontSize: 37, fontWeight: FontWeight.w600)),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text("kcal", style: normalText.copyWith(fontSize: 14)),
          //   ],
          // )
          //   ],
          // ),
          SizedBox(
            height: 2.h,
          ),
          // NutritionalBar(
          //   carbsPercent:
          //       userProvider.myNutrition?.carbPercentage.toDouble() ?? 0,
          //   fatPercent: userProvider.myNutrition?.fatPercentage.toDouble() ?? 0,
          //   proteinPercent:
          //       userProvider.myNutrition?.proteinPercentage.toDouble() ?? 0,
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          // NutritionInfoBox(
          //   carbs: userProvider.myNutrition?.carbohydrate ?? 0,
          //   protein: userProvider.myNutrition?.protein ?? 0,
          //   fat: userProvider.myNutrition?.fat ?? 0,
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          CaloriRow(
            target: userProvider.currentDay!.targetCalories ?? 0,
            asupan: userProvider.myNutrition?.intakeCalories ?? 0,
            aktivitas: userProvider.currentDay!.activityCalories ?? 0,
            kaloriTersedia: userProvider.currentDay!.calorieLeft ?? 0,
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider()
        ],
      );
    });
  }
}

class MyMisssion extends StatelessWidget {
  const MyMisssion({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.currentDay?.missions == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Center(child: CircularProgressIndicator());
      }
      if (userProvider.currentDay?.missions == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Tidak ada misi yang ditemukan'),
          ),
        );
      }

      return Mission(
        myMission: userProvider.currentDay!.missions,
        isPremium: userProvider.user?.isVip ?? 0,
      );
    });
  }
}
