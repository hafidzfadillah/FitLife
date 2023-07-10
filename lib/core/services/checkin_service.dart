import 'package:fitlife/core/models/checkin/checkin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/base_api.dart';
import '../models/api/api_response.dart';
import '../models/api/api_result_model.dart';

class CheckinService {
  BaseAPI api;
  CheckinService(this.api);

  Future<ApiResultList<CheckinModel>> getCheckin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    APIResponse response = await api.get(api.endpoint.dailyLogin, useToken: true, token: token);

    print('RSP Rewards : ${response.data}');

    return ApiResultList<CheckinModel>.fromJson(response.data,
        (data) => data.map((e) => CheckinModel.fromJson(e)).toList(), "data");
  }

  Future<APIResponse> claim(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post('${api.endpoint.dailyLogin}/$id',
        useToken: true, token: token);

    return response;
  }
}
