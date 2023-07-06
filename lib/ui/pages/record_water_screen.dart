import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/congratulation_screen.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/drink_progress_bar.dart';
import 'package:fitlife/ui/widgets/history_card.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:page_transition/page_transition.dart';

class RecordWaterScreen extends StatefulWidget {
  const RecordWaterScreen({Key? key}) : super(key: key);

  @override
  State<RecordWaterScreen> createState() => _RecordWaterScreenState();
}

class _RecordWaterScreenState extends State<RecordWaterScreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: CustomAppBar(
        title: 'Asupan Minum',
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(
          iconColor : Color(0xff6FB6E1),
          onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const RecordWaterScreenBody(),
      ),
    );
  }
}

class RecordWaterScreenBody extends StatelessWidget {
  const RecordWaterScreenBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.clearMyNutrition();
    userProvider.clearMyDrink();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
        builder: (context, connectionProv, userProvider, child) {
      if (connectionProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      return SafeArea(
          child: RefreshIndicator(
        onRefresh: () => refreshHome(context),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 33),
                children: [
                  const _UserDrinkProgress(),
                    const SizedBox(
                    height: 20,
                  ),

                  Row(children: [
                    Image.asset(
                      'assets/images/pandai_head.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedTextKit(
                          isRepeatingAnimation: false,
                          pause: Duration(seconds: 2000),
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'Tahukah kamu  ? ',
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w600
                                ))
                          ]),
                  ],),
                 
                    

                  const SizedBox(
                    height: 16,
                  ),
                        AnimatedTextKit(
                          isRepeatingAnimation: false,
                          pause: Duration(seconds: 2000),
                          animatedTexts: [
                            TypewriterAnimatedText(
                               "Dengan meminum gelas 8 hari sekali Dapat memelihara fungsi ginjal. Menghindari dehidrasi. Mengurangi risiko kanker kandung kemih.", textStyle: normalText.copyWith(
                        fontSize: 14,
                        color: const Color(0xff484848),
                        fontWeight: FontWeight.w400)
                          ),
                  ],),
                  
                
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "History Asupan Minum",
                    style: normalText.copyWith(
                        fontSize: 16,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const _UserHistoryDrink(),
                ],
              ),
            ),
            SwipeToDrink(
              userProvider: userProvider,
            )
          ],
        ),
      ));
    });
  }
}

class _UserDrinkProgress extends StatelessWidget {
  const _UserDrinkProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myMission == null && !userProvider.onSearch) {
        userProvider.getMyMission();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProvider.myMission == null && userProvider.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

      final mission = userProvider.myMission!
          .firstWhere((m) => m.name == "Catat Aktivitas Minum");
      final int currentDrink = mission.current;

      return Center(
        child: DrinkProgressBar(
            currentDrink: currentDrink, goalDrink: 8, width: 200 , color: Color(0xff6FB6E1) ),
      );
    });
  }
}

class _UserHistoryDrink extends StatelessWidget {
  const _UserHistoryDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.userDrink == null && !userProvider.onSearch) {
        userProvider.getUserHistoryDrink();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProvider.userDrink == null && userProvider.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

     
       
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userProvider.userDrink?.length,
        itemBuilder: (context, index) {
          return HistoryCard(
            title: 'Catat Asup Minum',
                    date: DateFormat('dd MMMM yyyy, HH:mm:ss')
                .format(userProvider.userDrink![index].createdAt),
            value: userProvider.userDrink![index].value,
            urlIcon: "assets/images/drink-water.png",
            unit: 'Gelas',
            withTarget: true,
            target: 8,
          );
        },
      );
    });
  }
}

class SwipeToDrink extends StatefulWidget {
  const SwipeToDrink({super.key, required this.userProvider});

  final UserProvider userProvider;

  @override
  State<SwipeToDrink> createState() => _SwipeToDrinkState();
}

class _SwipeToDrinkState extends State<SwipeToDrink> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SwipeableButtonView(
        buttonText: 'Catat Asup Minum',
        buttonWidget: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
        activeColor:  Color(0xff6FB6E1),
        isFinished: isFinished,
        onWaitingProcess: () {
          widget.userProvider.storeDrink();

          Future.delayed(const Duration(seconds: 1), () {
            widget.userProvider.clearMyMission();

            setState(() {
              isFinished = true;
            });
          });
        },
        onFinish: () async {
          setState(() {
            isFinished = false;

            if (widget.userProvider.userDrink!.length == 8) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const CongratulationScreen()));
            }
          });
        },
      ),
    );
  }
}
