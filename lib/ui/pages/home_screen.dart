// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:fitlife/core/viewmodels/checkin/checkin_provider.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/reward_item.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
    // userProvider.getMyMission();
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
    return FloatingDraggableWidget(
      floatingWidget: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed('/chatbot');
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.7)),
                width: 8.h,
                height: 8.h,
              ),
              Lottie.asset(
                'assets/json/chatbot.json',
                repeat: true,
                reverse: false,
              ),
            ],
          )),
      autoAlign: true,
      floatingWidgetHeight: 8.h,
      floatingWidgetWidth: 8.h,
      mainScreenWidget: Scaffold(
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
                    InkWell(
                      onTap: () {
                        _showCheckinModal(context, userProvider);
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            color: Color(0xFFFFE590)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Check-In harian',
                              style: GoogleFonts.poppins(),
                            )),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
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
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Lihat detail',
                                      style: GoogleFonts.poppins(
                                        color: primaryDarkColor,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                percent: userProvider.currentDay == null
                                    ? 0
                                    : (userProvider
                                            .currentDay!.percentageSuccess! /
                                        100),
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
        }),
      ),
    );
  }

  void _showCheckinModal(BuildContext context, UserProvider userProv) async {
    final claim = await showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.h),
                  topRight: Radius.circular(2.h))),
          child: Column(
            children: [
              Container(
                width: 0.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: neutral30,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Check-in Harian',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(child: DailyCheckin()),
              Consumer<CheckinProvider>(builder: (context, checkProvider, _) {
                return checkProvider.list != null &&
                        checkProvider.list!.isNotEmpty
                    ? RoundedButton(
                        title: 'Klaim',
                        style: GoogleFonts.poppins(color: blackColor),
                        background: primaryColor,
                        onClick: () async {
                          if(checkProvider.currentDay != null && checkProvider.currentDay!.rewardReceived == 1) {
                            EasyLoading.showInfo('Kamu sudah check-in hari ini');
                            return;
                          }
                          EasyLoading.show(
                              status: 'Memroses permintaan kamu..');
                          bool result = await checkProvider
                              .claimReward('${checkProvider.currentDay?.id}');

                          if (result) {
                            EasyLoading.showSuccess(
                                'Hore, klaim reward berhasil!');
                            Navigator.of(context).pop(result);
                          } else {
                            EasyLoading.showError(
                                'Klaim reward gagal :( Silakan coba lagi');
                          }
                        },
                        width: double.infinity)
                    : Container();
              })
            ],
          ),
        );
      },
    );

    if (claim != null && claim) {
      userProv.getUserData();
      userProv.getMyMission();
      CheckinProvider.instance(context).getRewards();
    }
  }
}

class DailyCheckin extends StatelessWidget {
  const DailyCheckin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckinProvider>(
      builder: (context, value, child) {
        if (value.list == null) {
          if (!value.onSearch) {
            value.getRewards();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (value.list!.isEmpty) {
          return Center(
            child: Text('Tidak ada data'),
          );
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              mainAxisSpacing: 1.h,
              crossAxisSpacing: 1.h),
          itemCount: value.list!.length,
          itemBuilder: (context, index) =>
              RewardItem(model: value.list![index], index: index + 1),
        );
      },
    );
  }
}

class UserNutrion extends StatelessWidget {
  const UserNutrion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.currentDay == null && !userProvider.onSearch) {
        // userProvider.getNutrion();

        return Center(child: CircularProgressIndicator());
      }
      if (userProvider.currentDay == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Center(child: CircularProgressIndicator());
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
      if (userProvider.currentDay?.missions == null) {
        // if the categories are being searched, show a skeleton loading
        if (!userProvider.onSearch) {
          userProvider.getMyMission();
        }

        return Center(child: CircularProgressIndicator());
      }

      if (userProvider.currentDay!.missions!.isEmpty) {
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
