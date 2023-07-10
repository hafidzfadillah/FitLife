import 'package:fitlife/core/models/checkin/checkin_model.dart';
import 'package:fitlife/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/checkin_service.dart';

class CheckinProvider extends ChangeNotifier {
  List<CheckinModel>? _list;
  List<CheckinModel>? get list => _list;

  CheckinModel? _currentDay;
  CheckinModel? get currentDay => _currentDay;

  final checkinService = locator<CheckinService>();

  bool isDisposed = false;

  bool _onSearch = false;
  bool get onSearch => _onSearch;

  static CheckinProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getRewards() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      print('fetching rewards');
      final result = await checkinService.getCheckin();
      print('fetching rewards done');
      // print(result.data);

      if (result.data!.isNotEmpty) {
        _list = result.data;

        _currentDay = _list!.firstWhere((element) =>
            element.loginDate ==
            DateFormat('yyyy-MM-dd').format(DateTime.now()));
      } else {
        _list = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _list = [];
    }
    setOnSearch(false);
  }

  Future<bool> claimReward(String id) async {
    try {
      final result = await checkinService.claim(id);
      print("RESULT CLAIM : ${result.data}");

      getRewards();
      return true;
    } catch (e, s) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${s.toString()}");
    }

    return false;
  }

  // Set event login
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
