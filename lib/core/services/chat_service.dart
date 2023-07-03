import 'package:fitlife/core/data/base_api.dart';
import 'package:fitlife/core/models/api/api_response.dart';
import 'package:fitlife/core/models/api/api_result_model.dart';
import 'package:fitlife/core/models/message/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  BaseAPI api;
  ChatService(this.api);

  Future<ApiResult<MessageModel>> sendMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    APIResponse response = await api
        .post(api.endpoint.vitabot, useToken: true, token: token, data: {
      "text": message +
          ".Tambahan: batasi jawabanmu hingga tidak lebih dari 60 karakter. usahakan jawab dengan bahasa semi-formal dan selipkan respon positif.",
    });

    print(response.data);

    return ApiResult<MessageModel>.fromJson(
        response.data, (data) => MessageModel.fromJson(data), "data");
  }
}
