import 'package:fitlife/ui/pages/leaderboard_screen.dart';
import 'package:fitlife/ui/pages/shop_screen.dart';
import 'package:fitlife/ui/pages/topup_bamboo_screen.dart';
import 'package:fitlife/ui/pages/topup_bamboo_succes_screen.dart';
import 'package:flutter/material.dart';
import '../core/models/survey/survey_model.dart';
import '../ui/pages/FoodDetailScreen.dart';
import '../ui/pages/article_screen.dart';
import '../ui/pages/chat_bot.dart';
import '../ui/pages/food_list_screen.dart';
import '../ui/pages/inputWorkout.dart';
import '../ui/pages/listSport.dart';
import '../ui/pages/premium_screen.dart';
import '../ui/pages/product_search_screen.dart';
import '../ui/pages/profileScreen.dart';
import '../ui/pages/programScreen.dart';
import '../ui/pages/record_food_screen.dart';
import '../ui/pages/record_run_screen.dart';
import '../ui/pages/record_sport_screen.dart';
import '../ui/pages/record_water_screen.dart';
import '../ui/pages/sportActionScreen.dart';
import '../ui/pages/step_add_screen.dart';
import '../ui/pages/survey/loadingScreen.dart';
import '../ui/pages/survey/resultScreen.dart';
import '../ui/pages/survey/surveyScreen.dart';
import '../ui/pages/vita_add_hearth_rate.dart';
import '../ui/pages/vita_pulse_screen.dart';

import '../ui/pages/daftarScreen.dart';
import '../ui/pages/loginScreen.dart';
import '../ui/pages/main_pages.dart';
import '../ui/pages/onboarding.dart';
import '../ui/pages/record_weight_screen.dart';
import '../ui/pages/splashScreen.dart';
import '../ui/pages/weight_add_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/on-boarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => DaftarScreen());
      case '/survey':
        return MaterialPageRoute(builder: (_) => SurveyScreen());
      case '/loading-survey':
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case SurveyResultScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SurveyResultScreen(result: args as SurveyModel));

      case '/home':
        return MaterialPageRoute(builder: (_) => MainPages());
      case '/chatbot':
        return MaterialPageRoute(builder: (_) => ChatbotScreen());
      case '/food-record':
        return MaterialPageRoute(builder: (_) => RecordFoodScreen());
      case '/food-detail':
        return MaterialPageRoute(builder: (_) => FoodDetailScreen());
      case '/food-list':
        return MaterialPageRoute(
            builder: (_) => FoodListScreen(
                  defaultMealType: 'Makan Pagi',
                ));
      case '/article':
        return MaterialPageRoute(builder: (_) => ArticleScreen());

      case '/program':
        return MaterialPageRoute(builder: (_) => ProgramScreen());

      case '/water-record':
        return MaterialPageRoute(builder: (_) => RecordWaterScreen());
      case '/vita-pulse':
        return MaterialPageRoute(builder: (_) => VitaPulseScreen());
      case '/record-sport':
        return MaterialPageRoute(builder: (_) => RecordSportScreen());
      case '/list-sport':
        return MaterialPageRoute(
            builder: (_) => ListSport(data: args as Map<String, dynamic>));
      case '/action-sport':
        return MaterialPageRoute(
            builder: (_) =>
                SportActionScreen(data: args as List<Map<String, dynamic>>));
      case '/input-sport':
        return MaterialPageRoute(builder: (_) => const InputWorkoutScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/product-search':
        return MaterialPageRoute(builder: (_) => const ProductSearchScreen());
      case '/add-user-health-rate':
        return MaterialPageRoute(builder: (_) => const VitaAddHealthScreen());
      case '/record-weight':
        return MaterialPageRoute(builder: (_) => const RecordWeightScreen());
      case '/record-add-weight':
        return MaterialPageRoute(builder: (_) => const WeightAddScreen());
      case '/premium':
        return MaterialPageRoute(builder: (_) => const PremiumScreen());
      case '/record-sport-run':
        return MaterialPageRoute(builder: (_) => const RecordRunScreen());
      case '/record-add-step':
        return MaterialPageRoute(builder: (_) => const StepAddScren());
      case '/shop' : 
        return MaterialPageRoute(builder: (_) => const ShopScreen()); 

      case '/topup-bamboo':
        return MaterialPageRoute(builder: (_) => TopUpBambooScreen());
      case '/topup-bamboo-success':
        return MaterialPageRoute(builder: (_) => TopUpBambooSuccessScreen());
      case '/leadeboard':
        return MaterialPageRoute(builder: (_) => LeaderboardScreen()); 
      // case '/product-detail':
      //   return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      // case '/cart':
      //   return MaterialPageRoute(builder: (_) => CartScreen());
      // case '/address':
      //   return MaterialPageRoute(builder: (_) => AddressScreen());
      // case '/add-address':
      //   return MaterialPageRoute(builder: (_) => AddAddress());
      // case '/checkout':
      //   return MaterialPageRoute(builder: (_) => CheckOutScreen());
      // case '/category-product':
      //   return MaterialPageRoute(builder: (_) => CategoryProduct());
      // case '/payment-list':
      //   return MaterialPageRoute(builder: (_) => PaymentListScreen());
      // case '/load-payment':
      //   return MaterialPageRoute(builder: (_) => LoadPaymentScreen());
      // case '/payment-code':
      //   return MaterialPageRoute(builder: (_) => PaymentCodeScreen());
      // case '/recipe-detail':
      //   return MaterialPageRoute(builder: (_) => RecipeDetailScreen());
      // case '/recipe':
      //   return MaterialPageRoute(builder: (_) => Discover());
      // case '/list-outlet':
      //   return MaterialPageRoute(builder: (_) => ListOutlet());
      // case '/no-internet':
      //   return MaterialPageRoute(builder: (_) => NoInternetConnection());
      // case '/search-product':
      //   return MaterialPageRoute(builder: (_) => ProductSearchScreen());
      // case '/search-location':
      //   return MaterialPageRoute(builder: (_) => SearchLocation());
      // case '/additional-information':
      //   return MaterialPageRoute(builder: (_) => AdditionalInformation());
      // case '/track-driver':
      // return MaterialPageRoute(builder: (_) => TrackDriver());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('Erorr'),
        ),
      );
    });
  }
}
