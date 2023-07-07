import 'package:fitlife/core/data/base_api.dart';
import 'package:fitlife/core/models/api/api_response.dart';
import 'package:fitlife/core/models/api/api_result_model.dart';
import 'package:fitlife/core/models/video/video_model.dart';

class VideoService {
  BaseAPI api;

  VideoService(this.api);

  Future<ApiResultList<Video>> getVideos() async {
    APIResponse response = await api.get(api.endpoint.getVideos);
    print('RSP REELS DATA${response.data}');
    

    return ApiResultList.fromJson(
        response.data, (data) => data.map((e) => Video.fromJson(e)).toList(), 'reels');
  }
}
