import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/categories/categories_provider.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';

import 'core/viewmodels/program/program_provider.dart';
import 'core/viewmodels/survey/surveyProvider.dart';
import 'core/viewmodels/user/user_provider.dart';

class GlobalProviders {
  /// Register your provider here
  static Future register() async => [
        ChangeNotifierProvider(create: (context) => ConnectionProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => SurveyProvider()),
        ChangeNotifierProvider(create: (context) => ProgramProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ];
}
