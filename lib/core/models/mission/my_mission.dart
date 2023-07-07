import 'package:fitlife/core/models/api/api_result_model.dart';

class MyDayModel extends Serializable {
   int? day;
   bool? isToday;
   int? percentageSuccess;
   int? missionSuccessCount;
   int? targetCalories;
   int? calorieLeft;
   int? activityCalories;
  List<MyMissionModel>? missions;

  MyDayModel(
      {required this.day,
      required this.isToday,
      required this.percentageSuccess,
      required this.missionSuccessCount,
      required this.targetCalories,
      required this.calorieLeft,
      required this.activityCalories,
      this.missions});

  MyDayModel.fromJson(Map<String, dynamic> json) {
    

    day = json['day'];
    isToday = json['is_today'];
    percentageSuccess = json['percentage_success'] ?? 0;
    missionSuccessCount = json['mission_success_count'] ?? 0;
    targetCalories = json['targetCalories'] ?? 0;
    calorieLeft = json['calorieLeft'] ?? 0;
    activityCalories = json['activityCalories'] ?? 0;
    if (json['missions'] != null) {
      missions = <MyMissionModel>[];
      json['missions'].forEach((v) {
        missions!.add(MyMissionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['day'] = day;
    data['is_today'] = isToday;
    data['percentage_success'] = percentageSuccess;
    data['mission_success_count'] = missionSuccessCount;
    data['targetCalories'] = targetCalories;
    data['calorieLeft'] = calorieLeft;
    data['activityCalories'] = activityCalories;
    if (missions != null) {
      data['missions'] = missions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyMissionModel extends Serializable {
  final String name;
  final String description;
  final String icon;
  final String colorTheme;
  final int coin;
  final int target;
  final int current;
  final String typeTarget;
  final String status;
  final String date;
  final num percentageSuccess;
  final String route;

  MyMissionModel(
      {required this.name,
      required this.description,
      required this.icon,
      required this.colorTheme,
      required this.coin,
      required this.target,
      required this.current,
      required this.typeTarget,
      required this.status,
      required this.date,
      required this.percentageSuccess,
      required this.route});

  factory MyMissionModel.fromJson(Map<String, dynamic> json) => MyMissionModel(
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        icon: json['icon'] ?? "",
        colorTheme: json['color_theme'] ?? '0',
        // int.parse(json['color_theme'] ?? "0"),
        coin: json['coin'] ?? 0,
        target: json['target'] ?? 0,
        current: json['current'] ?? 0,
        typeTarget: json['type_target'] ?? "",
        status: json['status'] ?? "",
        date: json['date'] ?? "",
        percentageSuccess: json['percentange_success'] ?? 0,
        route: json['route'],
      );
  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "icon": icon,
        "color_theme": colorTheme.toString(),
        "coin": coin,
        "target": target,
        "current": current,
        "type_target": typeTarget,
        "status": status,
        "date": date,
        "percentange_success": percentageSuccess,
        'route': route
      };
}
