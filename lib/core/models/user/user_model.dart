import 'package:fitlife/core/models/api/api_result_model.dart';

class UserModel extends Serializable {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int age;
  final String gender;
  final int height;
  final int weight;
  final num bmi;
  final String goal;
  final int targetWeight;
  final num recommendCalories;
  final int bamboo;
  final int coin;
  final int isVip;
  final int isSurveyed;
  final DateTime? vipExpiredAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.goal,
    required this.targetWeight,
    required this.recommendCalories,
    required this.coin,
    required this.bamboo,
    required this.isSurveyed,
    required this.isVip,
    required this.vipExpiredAt,
    
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "Sobat",
        email: json['email'] ?? "email",
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.parse(json['email_verified_at'])
            : null,
        createdAt: DateTime.parse(json['created_at'] ?? '00000000'),
        updatedAt: DateTime.parse(json['updated_at'] ?? '00000000'),
        age: json['age'] ?? 0,
        gender: json['gender'] ?? "-",
        height: json['height'] ?? 0,
        weight: json['weight'] ?? 0,
        bmi: json['bmi'] ?? 0.0,
        goal: json['goal'] ?? "",
        targetWeight: json['target_weight'] ?? 0,
        recommendCalories: json['recommend_calories'] ?? 0,
        coin: json['coin'] ?? 0,
        isVip: json['vip'] ?? 0,
        vipExpiredAt: json['vip_expired_at'] != null
            ? DateTime.parse(json['vip_expired_at'])
            : null,
        bamboo: json['bamboo'] ?? 0,
        isSurveyed: json['is_surveyed'] ?? 0
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "age": age,
        "gender": gender,
        "height": height,
        "weight": weight,
        "bmi": bmi,
        "goal": goal,
        "target_weight": targetWeight,
        "recommend_calories": recommendCalories,
        "coin": coin,
        "is_vip": isVip,
        "vip_expired_at": vipExpiredAt?.toIso8601String(),
        "bamboo": bamboo,
        "is_surveyed":isSurveyed
      };
}
