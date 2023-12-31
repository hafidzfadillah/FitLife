import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/button.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../../core/viewmodels/user/user_provider.dart';
import '../widgets/history_card.dart';

class RecordWeightScreen extends StatelessWidget {
  const RecordWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: lightModeBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, '/record-add-weight');

          if (result == true) {
            Navigator.pop(context);
          }
        },
        backgroundColor: Color(0xff8D5EBC),
        
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: CustomAppBar(
        title: 'Record  Berat Badan',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(
          iconColor:  Color(0xff8D5EBC),
          onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: ChangeNotifierProvider(
          create: (context) => UserProvider(), child: RecordWeightBody()),
    );
  }
}

class RecordWeightBody extends StatelessWidget {
  const RecordWeightBody({
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Berat badan saat ini",
                      style: normalText.copyWith(
                          fontSize: 14, color: const Color(0xff454545))),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          (userProv.userWeight == null ||
                                  userProv.userWeight?.isEmpty == true)
                              ? "0"
                              : userProv.userWeight?.last.value.toString() ??
                                  "0", // mengambil data terakhir dari userProv.userWeight
                          style: normalText.copyWith(
                              fontSize: 37, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("kg", style: normalText.copyWith(fontSize: 14)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _UserWeightHistory()
            ],
          ),
        );
      },
    );
  }
}

class _UserWeightHistory extends StatelessWidget {
  const _UserWeightHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.userWeight == null && !userProvider.onSearch) {
        userProvider.getUserWeightHistory();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProvider.userWeight == null && userProvider.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "History berat badan",
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
              itemCount: userProvider.userWeight!.length,
              itemBuilder: (context, index) {
                return HistoryCard(
                  unit: "kg",
                  withTarget: false,
                  urlIcon:  "assets/images/icon_m5.png",
                  backgroundColor:  Color(0xffFAF5FF),
                  title: "Catatan berat badan",
                  value: userProvider.userWeight?[index].value ?? 0,
                  date: userProvider.userWeight?[index].createdAt.toString() ??
                      "",
                );
              },
            )
          ],
        ),
      );
    });
  }
}
