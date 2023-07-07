import 'package:fitlife/core/viewmodels/user/user_provider.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/input_costume.dart';
import 'package:fitlife/ui/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopUpBambooScreen extends StatefulWidget {
  TopUpBambooScreen({Key? key});

  @override
  State<TopUpBambooScreen> createState() => _TopUpBambooScreenState();
}

class _TopUpBambooScreenState extends State<TopUpBambooScreen> {
  int selectedValue = 0;

  final UserProvider _userProvider = UserProvider();

  TextEditingController bamboo = TextEditingController(text: "");
  TextEditingController coin = TextEditingController(text: "");

  bool showWarning = false;

  @override
  void initState() {
    super.initState();
    bamboo.addListener(_calculateCoinValue);
  }

  @override
  void dispose() {
    bamboo.removeListener(_calculateCoinValue);
    bamboo.dispose();
    coin.dispose();
    super.dispose();
  }

  void _calculateCoinValue() {
    final int bambooValue = int.tryParse(bamboo.text) ?? 0;
    final int calculatedCoinValue = bambooValue ~/ 10;
    coin.text = calculatedCoinValue.toString();

    setState(() {
      showWarning = bambooValue < 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(selectedValue);
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: Column(
          children: [
            MainTopBar(
              title: 'Toko Pandan',
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bamboo ?",
                        style: GoogleFonts.poppins(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Kamu bisa gunakan bamboo sebagai tiket agar bisa menanyakan sesuatu ke Pandai (Pandan AI)",
                        style:
                            textRegularStyle.copyWith(color: Color(0xff979797)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Pilih Jumlah Bamboo",
                    style: GoogleFonts.poppins(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    physics: NeverScrollableScrollPhysics(),
                    children: _buildBambooNominalWidgets(),
                  ),
                  Text(
                    "Transaksi",
                    style: GoogleFonts.poppins(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: showWarning,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Minimal pembelian 10 Bamboo',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  CustomFormField(
                    hintText: 'Masukan Jumlah Bamboo',
                    state: bamboo,
                    prefixIcon: Image.asset(
                      "assets/images/bamboo.png",
                      width: 50,
                      height: 50,
                    ),
                    labelText: 'Jumlah Bamboo',
                  ),
                  SizedBox(height: 16),
                  CustomFormField(
                    hintText: 'Jumlah Koin dibayar',
                    isEnable: false,
                    state: coin,
                    prefixIcon: Image.asset(
                      "assets/images/coin.png",
                      width: 50,
                      height: 50,
                    ),
                    labelText: 'Jumlah Koin dibayar',
                  ),
                  SizedBox(height: 16),
                  RoundedButton(
                      background: primaryColor,
                      width: double.infinity,
                      title: 'Tukar',
                      style: GoogleFonts.poppins(color: Colors.black),
                      onClick: () {
                        // call provider and call method convert bamboo to coin
                        // and pass the value of bamboo
                        _userProvider.convertBamboo(int.parse(coin.text));
                        Navigator.pushNamed(context, '/topup-bamboo-success');
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBambooNominalWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < 6; i++) {
      int value = (i + 1) * 10;
      widgets.add(
        BambooNominalWidget(
          value: value,
          isSelected: selectedValue == value,
          onPressed: () {
            setState(() {
              selectedValue = value;
              // edit text editing
              bamboo.text = selectedValue.toString();
            });
          },
        ),
      );
    }

    return widgets;
  }
}

class BambooNominalWidget extends StatelessWidget {
  final int value;
  final bool isSelected;
  final VoidCallback onPressed;

  const BambooNominalWidget({
    required this.value,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : const Color(0xffD5D2D2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/bamboo.png",
              width: 50,
              height: 50,
            ),
            Text(
              value.toString(),
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.green : Color(0xff00C680),
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
