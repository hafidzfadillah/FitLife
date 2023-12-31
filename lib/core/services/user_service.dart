import 'dart:convert';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlife/core/data/base_api.dart';
import 'package:fitlife/core/models/api/api_response.dart';
import 'package:fitlife/core/models/api/api_result_model.dart';
import 'package:fitlife/core/models/bpm/bpm_model.dart';
import 'package:fitlife/core/models/bpm/healt_data_model.dart';
import 'package:fitlife/core/models/foods/food_lite.dart';
import 'package:fitlife/core/models/mission/my_mission.dart';
import 'package:fitlife/core/models/nutrion/nutrion_model.dart';
import 'package:fitlife/core/models/transaction/transaction_model.dart';
import 'package:fitlife/core/models/user/user_drink.dart';
import 'package:fitlife/core/models/user/user_food.dart';
import 'package:fitlife/core/models/user/user_model.dart';
import '../models/exercise/exercise_model.dart';
import '../models/step/step_model.dart';
import '../models/weight/weight_model.dart';

class UserService {
  BaseAPI api;
  UserService(this.api);
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', userData['access_token']);
    await prefs.setInt('id', userData['user']['id']);
    await prefs.setString('name', userData['user']['name']);
    await prefs.setString('email', userData['user']['email']);
    await prefs.setString('created_at', userData['user']['created_at']);
    await prefs.setString('updated_at', userData['user']['updated_at']);
    await prefs.setInt('age', userData['user']['age'] ?? 0);
    await prefs.setString('gender', userData['user']['gender'] ?? 'laki-laki');
    await prefs.setInt('height', userData['user']['height'] ?? 0);
    await prefs.setInt('weight', userData['user']['weight'] ?? 0);
    await prefs.setDouble('bmi', userData['user']['bmi'] ?? 0);
    await prefs.setString('goal', userData['user']['goal'] ?? 'maintain');
    await prefs.setInt('target_weight', userData['user']['target_weight'] ?? 0);
    await prefs.setInt(
        'recommend_calories', userData['user']['recommend_calories'] ?? 0);
    await prefs.setInt('point', userData['user']['point'] ?? 0);
  }

  Future<void> saveUserDaftar(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', userData['access_token']);
    await prefs.setInt('id', userData['user']['id']);
    await prefs.setString('name', userData['user']['name']);
    await prefs.setString('email', userData['user']['email']);
    await prefs.setString('created_at', userData['user']['created_at']);
    await prefs.setString('updated_at', userData['user']['updated_at']);
  }

  Future<ApiResult<UserModel>> login(String email, String password) async {
    Map<String, dynamic> data = {"email": email, "password": password};
    APIResponse response = await api.post(api.endpoint.login, data: data);

    final userData = response.data;
    print(data);
    print('User Data: $userData');

    // Save user data to shared preference.
    await saveUserData(userData!);

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "user");
  }

  Future<ApiResult<UserModel>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response =
        await api.post(api.endpoint.getUser, useToken: true, token: token);
    final userData = response.data;

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "data");
  }

  Future<ApiResult<UserModel>> daftar(
      String name, String email, String password) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password
    };
    APIResponse response = await api.post(api.endpoint.register, data: data);

    final userData = response.data;

    // Save user data to shared preference.
    await saveUserDaftar(userData!);

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "user");
  }

  Future<ApiResult<NutrionModel>> getUserNutrition({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getDailyDataDetail,
        useToken: true, token: token, data: {"date": dateStr});

    return ApiResult<NutrionModel>.fromJson(response.data?['data'],
        (data) => NutrionModel.fromJson(data), "my_nutrion");
  }

  Future<ApiResultList<MyDayModel>> getUserMission({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    await initializeDateFormatting();

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    print(dateStr);

    APIResponse response =
        await api.get(api.endpoint.getDailyData, useToken: true, token: token);

    // print('RSP : $response');
    // print('RSP Mission : ${response.data}');
    // print('RSP Mission Data : ${response.data?['data']}');

    return ApiResultList<MyDayModel>.fromJson(response.data,
        (data) => data.map((e) => MyDayModel.fromJson(e)).toList(), "data");
    return ApiResultList<MyDayModel>.fromJson(response.data,
        (data) => data.map((e) => MyDayModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<UserDrinkModel>?> storeDrink() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response =
        await api.post(api.endpoint.storeDrink, useToken: true, token: token);

    if (response.statusCode == 200) {
      final data = response.data;
      final userDrink = ApiResultList<UserDrinkModel>.fromJson(
          data,
          (data) => data.map((e) => UserDrinkModel.fromJson(e)).toList(),
          "data");

      return userDrink;
    } else {
      return null;
    }
  }

  Future<ApiResultList<BpmModel>?> storeBpm(int bpm) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post(api.endpoint.storeBpm,
        useToken: true, token: token, data: {'bpm': bpm});

    if (response.statusCode == 200) {
      final data = response.data;
      final userBpm = ApiResultList<BpmModel>.fromJson(data,
          (data) => data.map((e) => BpmModel.fromJson(e)).toList(), "data");

      return userBpm;
    } else {
      return null;
    }
  }

  Future<ApiResultList<WeightModel>?> storeWeight(int bpm) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post(api.endpoint.storeWeight,
        useToken: true, token: token, data: {'weight': bpm});

    if (response.statusCode == 200) {
      final data = response.data;
      final userWeight = ApiResultList<WeightModel>.fromJson(data,
          (data) => data.map((e) => WeightModel.fromJson(e)).toList(), "data");

      return userWeight;
    } else {
      return null;
    }
  }

  Future<ApiResultList<StepModel>?> storeStep(int step) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post(api.endpoint.storeStep,
        useToken: true, token: token, data: {'step': step});

    if (response.statusCode == 200) {
      final data = response.data;
      final userStep = ApiResultList<StepModel>.fromJson(data,
          (data) => data.map((e) => StepModel.fromJson(e)).toList(), "data");

      return userStep;
    } else {
      return null;
    }
  }

  Future<ApiResultList<UserDrinkModel>> getUserHistoryDrink(
      {DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.historyDrink,
        useToken: true, token: token, data: {"date": dateStr});
    print(response.data);

    return ApiResultList<UserDrinkModel>.fromJson(response.data,
        (data) => data.map((e) => UserDrinkModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResult<HealthDataModel>> getHealthData({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getBpm,
        useToken: true, token: token, data: {"date": dateStr});

    print("==============");
    print(response.data);
    print("==============");

    return ApiResult<HealthDataModel>.fromJson(
        response.data, (data) => HealthDataModel.fromJson(data), "data");
  }

  Future<ApiResultList<BpmModel>> getHistoryHealth({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getBpm,
        useToken: true, token: token, data: {"date": dateStr});

    print("==============");
    print(response.data);
    print("==============");

    return ApiResultList<BpmModel>.fromJson(
        response.data?['data'],
        (data) => data.map((e) => BpmModel.fromJson(e)).toList(),
        "health_data");
  }

  Future<ApiResultList<UserFood>> getUserHistoryMeal({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.historyFood,
        useToken: true, token: token, data: {"date": dateStr});

    print(response.data);
    return ApiResultList<UserFood>.fromJson(response.data?['data'],
        (data) => data.map((e) => UserFood.fromJson(e)).toList(), "foods");
  }

  Future<ApiResult<FoodLiteModel>?> storeFoods(
      String mealType, List<FoodLiteModel> foods) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final foodMaps = foods
        .map((food) => {
              'food_id': food.id,
              'calorie_intake': food.calories,
              'carbohydrate_intake': food.carbs,
              'protein_intake': food.protein,
              'fat_intake': food.fat,
              'size': food.defaultSize,
              'unit': food.defaultServing,
            })
        .toList();

    if (mealType == 'Makan Pagi')
      mealType = 'breakfast';
    else if (mealType == 'Makan Siang')
      mealType = 'lunch';
    else if (mealType == 'Makan Malam')
      mealType = 'dinner';
    else
      mealType = 'snack';

    final requestBody = json.encode({
      'meal_type': mealType,
      'foods': foodMaps,
    });

    print(requestBody);

    APIResponse response = await api.post(
      api.endpoint.storeFoods,
      useToken: true,
      token: token,
      data: requestBody,
    );

    print(api.endpoint.storeFoods);
    final data = response.data;
    print(data);

    if (response.statusCode == 200) {
      final data = response.data;
      final result = ApiResult<FoodLiteModel>.fromJson(
          data, (data) => FoodLiteModel.fromJson(data), "data");
      return result;
    } else {
      return null;
    }
  }

  Future<ApiResult<ExerciseModel>?> storeExercise(
      List<ExerciseModel> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final exerciseMaps = exercises
        .map((exercise) => {
              'exercise_type_id': exercise.id,
              'duration': exercise.exerciseDuration,
            })
        .toList();

    final requestBody = json.encode({
      'exercises': exerciseMaps,
    });

    print(requestBody);

    APIResponse response = await api.post(
      api.endpoint.storeExercise,
      useToken: true,
      token: token,
      data: requestBody,
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final result = ApiResult<ExerciseModel>.fromJson(
          data, (data) => ExerciseModel.fromJson(data), "data");
      return result;
    } else {
      return null;
    }
  }

  Future<ApiResultList<WeightModel>> getWeightData({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getWeight,
        useToken: true, token: token, data: {"date": dateStr});

    return ApiResultList<WeightModel>.fromJson(response.data,
        (data) => data.map((e) => WeightModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<StepModel>> getStepData({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getStept,
        useToken: true, token: token, data: {"date": dateStr});

    return ApiResultList<StepModel>.fromJson(response.data,
        (data) => data.map((e) => StepModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<void>?> activeFreeTrial() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    await api.post(api.endpoint.activeFreeTrial, useToken: true, token: token);
  }

  Future<ApiResult<TransactionModel>> paymentPremium(String? planType) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post(api.endpoint.payPremium,
        useToken: true, token: token, data: {"plan_type": planType});

    return ApiResult<TransactionModel>.fromJson(
        response.data, (data) => TransactionModel.fromJson(data), "data");
  }

  Future<ApiResult<TransactionModel>> verifyPayment(
      String? transaction_id) async {
    APIResponse response = await api.post(api.endpoint.verifyPayment,
        data: {"transaction_id": transaction_id});

    return ApiResult<TransactionModel>.fromJson(
        response.data, (data) => TransactionModel.fromJson(data), "data");
  }

  Future<String> convertBamboo(int coin) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.post(api.endpoint.convertBamboo,
        useToken: true, token: token, data: {"coin": coin});

    // if status code 402
    if (response.statusCode == 402) {
      return  response.data?['message'];
    } else {
      return "success";
    }
  }
}
