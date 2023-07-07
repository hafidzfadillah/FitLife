import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/models/mission/my_mission.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/premium_screen.dart';
import 'package:fitlife/ui/widgets/MissionCard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            ListView.separated(
              shrinkWrap: true,
              itemCount: myMission!.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index > 0 && index % 2 != 0) {
                  if (index + 1 < myMission!.length) {
                    MyMissionModel x = myMission![index + 1];

                    myMission!.removeAt(index + 1);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MissionCard(
                          progress:
                              myMission![index].percentageSuccess.toDouble(),
                          missionColor: myMission![index].colorTheme,
                          title: myMission![index].name,
                          target: myMission![index].target,
                          current: myMission![index].current,
                          pointReward: myMission![index].coin,
                          unit: myMission![index].typeTarget,
                          icon: myMission![index].icon,
                          backgroundColor: myMission![index].colorTheme,
                          screen: myMission![index].name,
                          route: myMission![index].route,
                        ),
                        SizedBox(
                          width: 3.h,
                        ),
                        MissionCard(
                          progress: x.percentageSuccess.toDouble(),
                          missionColor: x.colorTheme,
                          title: x.name,
                          target: x.target,
                          current: x.current,
                          pointReward: x.coin,
                          unit: x.typeTarget,
                          icon: x.icon,
                          backgroundColor: x.colorTheme,
                          screen: x.name,
                          route: x.route,
                        )
                      ],
                    );
                  }
                }

                return index < myMission!.length
                    ? MissionCard(
                        progress:
                            myMission![index].percentageSuccess.toDouble(),
                        missionColor: myMission![index].colorTheme,
                        title: myMission![index].name,
                        target: myMission![index].target,
                        current: myMission![index].current,
                        pointReward: myMission![index].coin,
                        unit: myMission![index].typeTarget,
                        icon: myMission![index].icon,
                        backgroundColor: myMission![index].colorTheme,
                        screen: myMission![index].route,
                        route: myMission![index].route,
                      )
                    : Container();
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 3.h,
              ),
            )
          ],
        ),
      ],
    );
  }
}
