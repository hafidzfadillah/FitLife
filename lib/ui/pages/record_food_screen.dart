import 'package:fitlife/ui/widgets/NutrionInfoBox.dart';
import 'package:fitlife/ui/widgets/NutritionBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/calorie_box.dart';
import 'package:fitlife/ui/widgets/DatePicker.dart';
import 'package:fitlife/ui/widgets/log_food_card.dart';
import 'package:fitlife/ui/widgets/NutrientChart.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/loading/LoadingSingleBox.dart';

import '../widgets/CustomAppBar.dart';

class RecordFoodScreen extends StatelessWidget {
  const RecordFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: CustomAppBar(
          title: 'Aktivitas  Makan Saya',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          leading: CustomBackButton(
            iconColor:  const Color(0xffFFB029),
            onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const RecordFoodBody(),
        ));
  }
}

class RecordFoodBody extends StatelessWidget {
  const RecordFoodBody({super.key});
  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearMyNutrition();
    userProvider.clearMyFood();
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
              Text(
              'Log makan',
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
               const SizedBox(
              height: 16,
            ),
             const UserFoodActivity(),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Ringkasan',
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            const _UserNutrionWidget(),
            const SizedBox(
              height: 16,
            ),
          
         
          
          ],
        ),
      ));
    });
  }
}

class UserFoodActivity extends StatelessWidget {
  const UserFoodActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.userLunchFood == null && !userProvider.onSearch) {
        userProvider.getUserFood();

        return Center(
          child: LoadingSingleBox(),
        );
      }
      if (userProvider.userLunchFood == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Center(
          child: LoadingSingleBox(),
        );
      }

      return Column(
        children: [
          LogFoodCard(
            title: "Makan Pagi",
            icon: 'assets/images/icon_breakfast.png',
            foods: userProvider.userBreakfastFood!,
          ),
          LogFoodCard(
            title: "Makan Siang",
            icon: 'assets/images/icon_lunch.png',
            foods: userProvider.userLunchFood!,
          ),
          LogFoodCard(
            title: "Makan Malam",
            icon: 'assets/images/icon_dinner.png',
            foods: userProvider.userDinnerFood!,
          ),
          LogFoodCard(
            title: "Makanan Ringan",
            icon: 'assets/images/icon_snack.png',
            foods: userProvider.userSnacks!,
          ),
        ],
      );
    });
  }
}

class _UserNutrionWidget extends StatelessWidget {
  const _UserNutrionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myNutrition == null && !userProvider.onSearch) {
        userProvider.getNutrion();

        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (userProvider.myNutrition == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (userProvider.myNutrition == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(' Ups sepertinya terjadi kesalahan'),
          ),
        );
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sisa kalori",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          (userProvider.myNutrition?.calorieLeft ?? 0) < 0
                              ? "0"
                              : userProvider.myNutrition?.calorieLeft
                                      .toString() ??
                                  "0",
                          style: normalText.copyWith(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 139, 136, 136),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Konsumsi Kalori",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userProvider.myNutrition?.intakeCalories.toString() ??
                              "0",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xffEAE7E7),
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Akg ${userProvider.myNutrition?.akg.toString() ?? "0"}%",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xffB4B8BB),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userProvider.myNutrition?.targetCalories.toString() ??
                              "0",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CalorieBox(
                  percentage:
                     (userProvider.myNutrition?.akg.toDouble() ?? 0) / 100),
            ],
          ),
          const SizedBox(
            height: 16,
          ),


          SizedBox(
            height:  16,
          ),
          NutritionalBar(carbsPercent: 0.15, fatPercent: 0.1, proteinPercent: 0.25),
          const SizedBox(
            height: 16,
          ),

          NutritionInfoBox(carbs: 12, protein: 12, fat: 12)
          // NutrientChart(
          //   carbsPercentage:
          //       (userProvider.myNutrition?.carbPercentage.toDouble() ?? 0) *
          //           100,
          //   fatPercentage:
          //       (userProvider.myNutrition?.fatPercentage.toDouble() ?? 0) * 100,
          //   proteinPercentage:
          //       (userProvider.myNutrition?.proteinPercentage.toDouble() ?? 0) *
          //           100,
          // ),
        ],
      );
    });
  }
}
