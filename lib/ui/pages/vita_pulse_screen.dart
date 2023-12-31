import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/core/models/bpm/bpm_model.dart';
import 'package:fitlife/core/utils/navigation/navigation_utils.dart';
import 'package:fitlife/core/viewmodels/connection/connection.dart';
import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/dummy/PricePoint.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/history_card.dart';
import 'package:fitlife/ui/widgets/LineChart.dart';
import 'package:fitlife/ui/widgets/button.dart';

class VitaPulseScreen extends StatelessWidget {
  const VitaPulseScreen({Key? key}) : super(key: key);

  final bool isConnect = true;

  @override
  Widget build(BuildContext context) {
    if (isConnect == false) {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: CustomAppBar(
          title: 'VitaPulse',
          backgroundColor: Colors.white,
          elevation: 0,
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(bottom: 100),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 33),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon_misi_6.png'),
                const SizedBox(height: 20),
                Text('Terhubung dengan Fita Pulse',
                    style: normalText.copyWith(
                        fontSize: 16,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Text(
                    'Untuk terhubung dengan Fita Pulse , kamu perlu menyakalan bluetooth dan dekatkan dengan device Fita Pulse',
                    textAlign: TextAlign.center,
                    style: normalText.copyWith(
                        fontSize: 14,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w400)),
              ],
            )),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, '/add-user-health-rate');

          if (result == true) {
            Navigator.pop(context, true);
          }
        },
        backgroundColor: const Color(0xffF5D6D0),
        child: const Icon(Icons.add, color: Color(0xff372534)),
      ),
      appBar: CustomAppBar(
          title: 'Heart Rate',
          backgroundColor: const Color(0xffF5D6D0),
          elevation: 0,
          leading: Card(
            elevation: 0,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff372534),
                  ),
                )),
          )),
      body: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const VitaPulseScreenBody()),
    );
  }
}

class VitaPulseScreenBody extends StatelessWidget {
  const VitaPulseScreenBody({
    super.key,
  });

  Future<void> refreshHome(BuildContext context) async {
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
      builder: (context, connectionProv, userProv, _) {
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
            child: ListView(
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Color(0xffF5D6D0),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: _UserHealthSummary(),
                )),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
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
                        TypewriterAnimatedText('Tahukah kamu  ? ',
                            textAlign: TextAlign.center,
                            textStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w600))
                      ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                pause: Duration(seconds: 2000),
                animatedTexts: [
                  TypewriterAnimatedText(
                      "Detak Jantung Normal: Detak jantung normal pada orang dewasa yang sehat berada dalam rentang 60-100 bpm saat beristirahat. Namun, rentang ini dapat bervariasi tergantung pada faktor individu seperti usia, tingkat kebugaran, dan kondisi kesehatan.",
                      textStyle: normalText.copyWith(
                          fontSize: 14,
                          color: const Color(0xff484848),
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const _UserHistoryHealth(),
          ],
        ));
      },
    );
  }
}

class _UserHealthSummary extends StatelessWidget {
  const _UserHealthSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.userBpm == null && !userProvider.onSearch) {
        userProvider.getUserHistoryHealth();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProvider.userBpm == null && userProvider.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

      final List<int> bpmValues =
          userProvider.userBpm?.map((e) => e.value)?.toList() ?? [];

      if (bpmValues.isNotEmpty) {
        final int averageBpm =
            (bpmValues.reduce((a, b) => a + b) / bpmValues.length).round();
// Get heart rate data points for chart
        final List<FlSpot> heartRatePoints = [];
        for (final bpm in userProvider.userBpm ?? []) {
          final DateTime date = bpm.createdAt;
          final double x = date.millisecondsSinceEpoch.toDouble();
          final double y = bpm.value.toDouble();
          final FlSpot spot = FlSpot(x, y);
          heartRatePoints.add(spot);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '1 bpm',
                style: normalText.copyWith(
                    fontSize: 18,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 80),
            // Container(child: LineChartHeartRate(heartRatePoints)),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '0 bpm',
                style: normalText.copyWith(
                    fontSize: 14,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 80),
            Text(
                "Data Chart akan tersedia jika kamu sudah melakukan cek kesehatan lebih dari 1x ",
                textAlign: TextAlign.center,
                style: normalText.copyWith(
                    fontSize: 14,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w400)),
          ],
        );
      }
    });
  }
}

class _UserHistoryHealth extends StatelessWidget {
  const _UserHistoryHealth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.userBpm == null && !userProvider.onSearch) {
        userProvider.getUserHistoryHealth();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProvider.userBpm == null && userProvider.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "History Cek Kesehatan",
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userProvider.userBpm!.length,
              itemBuilder: (context, index) {
                return HistoryCard(
                  unit: "bpm",
                  withTarget: false,
                  title: "Catatan detak jantung",
                  value: userProvider.userBpm?[index].value ?? 0,
                  date: userProvider.userBpm?[index].createdAt.toString() ?? "",
                );
              },
            )
          ],
        ),
      );
    });
  }
}
