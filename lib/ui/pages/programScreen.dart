import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/core/viewmodels/program/program_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/ProgramCard.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/top_bar.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../../core/viewmodels/user/user_provider.dart';
import '../widgets/loading/LoadingSingleBox.dart';

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({Key? key}) : super(key: key);

  // list programs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => ProgramProvider())
        ],
        child: const ProgramBody(),
      ),
    );
  }
}

class ProgramBody extends StatelessWidget {
  const ProgramBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final programProv = ProgramProvider.instance(context);

    programProv.clearProducts();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
        builder: (context, connProv, userProv, _) {
      if (connProv.internetConnected == false) {
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
        onRefresh: (() => refreshHome(context)),
        child: Column(
          children: [
            MainTopBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  Text(
                    "Program Unggulan fitlife",
                    style: normalText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Consumer<ProgramProvider>(builder: (context, progProv, _) {
                    if (progProv.programs == null && !progProv.onSearch) {
                      progProv.getPrograms();

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: defMargin),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const LoadingSingleBox(),
                      );
                    }

                    if (progProv.programs == null && progProv.onSearch) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: defMargin),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const LoadingSingleBox(),
                      );
                    }

                    if (progProv.programs!.isEmpty) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child:
                              const Text('Tidak ada program tersedia saat ini'),
                        ),
                      );
                    }

                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 50.h,
                        autoPlayInterval: Duration(seconds: 5),
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        enlargeCenterPage: true,
                      ),
                      items: progProv.programs!.map((program) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ProgramCard(
                              title: program.programName,
                              description: program.programDescription,
                              image: program.image,
                            );
                          },
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(
                    height: 33,
                  ),
                  Container(
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: primaryColor),
                      ),
                      onPressed: () {
                        if (userProv.user?.isVip == 0) {
                          Navigator.pushNamed(
                            context,
                            '/premium',
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/sport-record',
                          );
                        }
                      },
                      child: Text(
                          userProv.user?.isVip != 0
                              ? 'Lihat Program'
                              : 'Gabung Program',
                          style: TextStyle(color: primaryColor)),
                    ),
                  ),
                ],
              ),
            ),
            // button join with primary color
          ],
        ),
      ));
    });
  }
}
