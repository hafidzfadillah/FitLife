import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/models/mission/my_mission.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/premium_screen.dart';
import 'package:fitlife/ui/widgets/MissionCard.dart';

class Mission extends StatelessWidget {
  Mission({Key? key, required this.myMission, required this.isPremium})
      : super(key: key);

  int finishMisison = 0;
  int totalMission = 6;

  List<MyMissionModel>? myMission;
  final int isPremium;

  // final totalMission =  myMission?.length;

  // final finishMissions =
  //     userProvider.myMission!.where((e) => e.status == 'finish');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        // Filter data yang memiliki status 'on-going'

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan jumlah tugas yang belum selesai
            Row(
              children: [
                Text(
                  "Misi kamu hari ini ",
                  style: normalText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff333333),
                  ),
                ),
                Text(
                  "${myMission?.where((element) => element.status == 'finish').length ?? 0}/${myMission?.length}",
                  style: normalText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff333333),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isPremium == 0)
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/premium');
                },
                child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFAEA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/premium.png',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                  "Yuk gabung ke Vita Premium banyak banget benefitnya",
                                  style: normalText.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    height: 1.7,
                                    color: const Color(0xff333333),
                                  )),
                              const SizedBox(height: 8),
                              Text(
                                "Coba Berbagai fitur AI dari kita seperti Vita bot , Vita Virtual Coach  dan Exercie plan",
                                style: normalText.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),

            const SizedBox(height: 16),

            // Menampilkan card misi
            Column(
              children: myMission!
                  .map((e) => MissionCard(
                        progress: e.percentageSuccess.toDouble(),
                        missionColor: e.colorTheme,
                        title: e.name,
                        target: e.target,
                        current: e.current,
                        pointReward: e.coin,
                        unit: e.typeTarget,
                        icon: e.icon,
                        backgroundColor: e.colorTheme,
                        screen: e.name,
                        route:  e.route,
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
