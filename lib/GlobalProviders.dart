import 'package:fitlife/core/viewmodels/video/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/categories/categories_provider.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';

import 'core/viewmodels/classify/classify_provider.dart';
import 'core/viewmodels/food/food_provider.dart';
import 'core/viewmodels/product/product_provider.dart';
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
        ChangeNotifierProvider(create: (create) => CategoryProvider()),
        ChangeNotifierProvider(create: (create) => UserProvider()),
        ChangeNotifierProvider(create: (create) => SurveyProvider()),
        ChangeNotifierProvider(create: (create) => ClassifyProvider()),
        ChangeNotifierProvider(create: (create) => FoodProvider()),
        ChangeNotifierProvider(create: (create) => ProductProvider()),
        ChangeNotifierProvider(create: (create) => ProgramProvider()),
        ChangeNotifierProvider(create: (create) => VideoProvider())
      ];
}
