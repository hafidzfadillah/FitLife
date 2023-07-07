import 'package:fitlife/core/models/api/api_result_model.dart';

class Shorts {
  bool? success;
  List<Video>? reels;

  Shorts({this.success, this.reels});

  Shorts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['reels'] != null) {
      reels = <Video>[];
      json['reels'].forEach((v) {
        reels!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (reels != null) {
      data['reels'] = reels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video extends Serializable {
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  String? summary;
  String? createdAt;
  String? updatedAt;

  Video(
      {this.id,
      this.title,
      this.description,
      this.videoUrl,
      this.summary,
      this.createdAt,
      this.updatedAt});

  Video.fromJson(Map<String, dynamic> json) {
    print('JSON REELS $json');
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['video_url'];
    summary = json['summary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['video_url'] = videoUrl;
    data['summary'] = summary;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
