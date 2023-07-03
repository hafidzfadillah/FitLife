import 'package:fitlife/core/data/base_api.dart';
import 'package:fitlife/core/models/api/api_response.dart';
import 'package:fitlife/core/models/api/api_result_model.dart';
import 'package:fitlife/core/models/article/article_model.dart';

class ArticleService {
  BaseAPI api;
  ArticleService(this.api);

  Future<ApiResultList<ArticleModel>> getArticles() async {
    APIResponse response = await api.get(api.endpoint.getArticles);

    return ApiResultList<ArticleModel>.fromJson(response.data,
        (data) => data.map((e) => ArticleModel.fromJson(e)).toList(), "data");
  }
}
