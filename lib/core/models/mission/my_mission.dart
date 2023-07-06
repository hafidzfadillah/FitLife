import 'package:fitlife/core/models/api/api_result_model.dart';

class MyMissionModel extends Serializable {
  final String name;
  final String description;
  final String icon;
  final int colorTheme;
  final int coin;
  final int target;
  final int current;
  final String typeTarget;
  final String status;
  final String date;
  final num percentageSuccess;
  final String route;

  MyMissionModel({
    required this.name,
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
    required this.route,
  });

  factory MyMissionModel.fromJson(Map<String, dynamic> json) => MyMissionModel(
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        icon: json['icon'] ?? "",
        colorTheme: int.parse(json['color_theme'] ?? "0"),
        coin: json['coin'] ?? 0,
        target: json['target'] ?? 0,
        current: json['current'] ?? 0,
        typeTarget: json['type_target'] ?? "",
        status: json['status'] ?? "",
        date: json['date'] ?? "",
        percentageSuccess: json['percentange_success'] ?? 0,
        route: json['route'] ?? "",
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
        "route": route,
      };
}
