// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int point = 0;
  String level = '';

  @override
  void initState() {
    super.initState();
    getData();
    print('trigger');
  }

  Future<void> getData() async {
    // get data from user_proivder
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0;
      level = prefs.getString('level') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        body: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const HomeScreenBody(),
        ));
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearMyNutrition();
    userProvider.clearMyMission();
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
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
            MainTopBar2(
              title: 'Hi, Sobat',
            ),
            Divider(),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                'Hari ke 1',
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
                          Text('1 dari 7 misi hari ini selesai'),
                          SizedBox(
                            height: 2.h,
                          ),
                          LinearPercentIndicator(
                            width: 50.w,
                            lineHeight: 1.h,
                            padding: EdgeInsets.all(0),
                            barRadius: Radius.circular(1.h),
                            percent: 1 / 7,
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
                // const SizedBox(
                //   height: 16,
                // ),
                UserNutrion(),
                SizedBox(
                  height: 2.h,
                ),
                MyMission2()
              ],
            ))
          ],
        ),
      ));
    });
  }
}

// class _MainTopBar extends StatelessWidget {
//   const _MainTopBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(builder: (context, userProvider, _) {
//       if (userProvider.user == null && !userProvider.onSearch) {
//         userProvider.getUserData(

//         );

//         return const LoadingSingleBox();
//       }
//       if (userProvider.user == null && userProvider.onSearch) {
//         // if the categories are being searched, show a skeleton loading
//         return const LoadingSingleBox();
//       }
//       return const MainTopBar();
//     });
//   }
// }

class UserNutrion extends StatelessWidget {
  const UserNutrion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myNutrition == null && !userProvider.onSearch) {
        userProvider.getNutrion();

        return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox());
      }
      if (userProvider.myNutrition == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox());
      }

      if (userProvider.myNutrition == null) {
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
            target: userProvider.myNutrition?.targetCalories ?? 0,
            asupan: userProvider.myNutrition?.intakeCalories ?? 0,
            aktivitas: userProvider.myNutrition?.activityCalories ?? 0,
            kaloriTersedia: (userProvider.myNutrition?.calorieLeft ?? 0) < 0
                ? 0
                : userProvider.myNutrition?.calorieLeft ?? 0,
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

class MyMission2 extends StatelessWidget {
  MyMission2({Key? key}) : super(key: key);
  // final List<int> itemList = [1, 2, 3, 4, 5, 6];
  final List<Map<String, dynamic>> itemList = [
    {
      'image': 'assets/images/makan.svg',
      'mission': 'Catat aktivitas makan',
      'poin': '15',
      'color': Color(0xFFFFB029)
    },
    {
      'image': 'assets/images/exercise.svg',
      'mission': 'Olahraga',
      'poin': '5',
      'color': Color(0xFFF9D171)
    },
    {
      'image': 'assets/images/running.svg',
      'mission': 'Track jogging',
      'poin': '5',
      'color': Color(0xFFF39CFF)
    },
    {
      'image': 'assets/images/water.svg',
      'mission': 'Minum 8 gelas',
      'poin': '5',
      'color': Color(0xFF8AD0E6)
    },
    {
      'image': 'assets/images/weight.svg',
      'mission': 'Catat berat badan',
      'poin': '5',
      'color': Color(0xFF8D5EBC)
    },
    {
      'image': 'assets/images/heart.svg',
      'mission': 'Catat detak jantung',
      'poin': '5',
      'color': Color(0xFFFE4C4C)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index > 0 && index % 2 != 0) {
            if (index + 1 < itemList.length) {
              Map<String, dynamic> x = itemList[index + 1];

              itemList.removeAt(index + 1);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Mission2(
                      number: '${itemList[index]['poin']}',
                      title: '${itemList[index]['mission']}',
                      color: itemList[index]['color'],
                      img: itemList[index]['image']),
                  SizedBox(
                    width: 3.h,
                  ),
                  Mission2(
                      number: '${x['poin']}',
                      title: '${x['mission']}',
                      color: x['color'],
                      img: x['image']),
                ],
              );
            }
          }

          return index < itemList.length
              ? Mission2(
                  number: '${itemList[index]['poin']}',
                  title: '${itemList[index]['mission']}',
                  color: itemList[index]['color'],
                  img: itemList[index]['image'])
              : Container();
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 3.h,
        ),
      ),
    );
  }
}

class Mission2 extends StatelessWidget {
  const Mission2(
      {Key? key,
      required this.number,
      required this.title,
      required this.img,
      required this.color})
      : super(key: key);
  final String number, title, img;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      valueColor: AlwaysStoppedAnimation(Colors.amber),
                      value: Random().nextDouble(),
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
                    child: SvgPicture.asset(
                      img,
                    ),
                    radius: 35,
                    backgroundColor: color,
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/images/badge_coin.svg'),
                  Text(
                    number,
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
    );
  }
}

class MyMisssion extends StatelessWidget {
  const MyMisssion({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myMission == null && !userProvider.onSearch) {
        userProvider.getMyMission();
        userProvider.getUserData();

        return const LoadingSingleBox();
      }
      if (userProvider.myMission == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return const LoadingSingleBox();
      }
      if (userProvider.myMission == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Tidak ada produk yang ditemukan'),
          ),
        );
      }

      return Mission(
        myMission: userProvider.myMission,
        isPremium: userProvider.user?.isPremium ?? 0,
      );
    });
  }
}
