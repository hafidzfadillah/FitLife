import 'package:fitlife/core/models/api/api_result_model.dart';

class CheckinModel extends Serializable{
  int? id;
  String? loginDate;
  int? rewardReceived;
  int? userId;
  String? rewardImage;
  String? rewardTitle;
  int? rewardValue;
  String? rewardType;
  String? createdAt;
  String? updatedAt;

   CheckinModel(
      {this.id,
      this.loginDate,
      this.rewardReceived,
      this.userId,
      this.rewardImage,
      this.rewardTitle,
      this.rewardValue,
      this.rewardType,
      this.createdAt,
      this.updatedAt});

      CheckinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginDate = json['login_date'];
    rewardReceived = json['reward_received'];
    userId = json['user_id'];
    rewardImage = json['reward_image'];
    rewardTitle = json['reward_title'];
    rewardValue = json['reward_value'];
    rewardType = json['reward_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['login_date'] = this.loginDate;
    data['reward_received'] = this.rewardReceived;
    data['user_id'] = this.userId;
    data['reward_image'] = this.rewardImage;
    data['reward_title'] = this.rewardTitle;
    data['reward_value'] = this.rewardValue;
    data['reward_type'] = this.rewardType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}