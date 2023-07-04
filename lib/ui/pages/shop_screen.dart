import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:fitlife/ui/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        body: SafeArea(
          child: Column(
            children: [
              const MainTopBar(
                title: 'Toko Pandan',
              ),
              Expanded(
                  child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(25),
                  //   height: 268,
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Stack(
                  //                   children: <Widget>[
                  //                     // Stroked text as border.
                  //                     Text(
                  //                       'VIP Member',
                  //                       style: GoogleFonts.bungee(
                  //                         fontSize: 29,
                  //                         foreground: Paint()
                  //                           ..style = PaintingStyle.stroke
                  //                           ..strokeWidth = 0.5
                  //                           ..color = Color(0XFF413757),
                  //                       ),
                  //                     ),
                  //                     // Solid text as fill.
                  //                     Text(
                  //                       'VIP Member',
                  //                       style: GoogleFonts.bungee(
                  //                         fontSize: 29,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 SizedBox(height: 8.0),
                  //                 Text(
                  //                   'dengan fitplus kamu dapat beragam fitur premium',
                  //                   style: GoogleFonts.poppins(
                  //                     fontSize: 14.0,
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),

                  //               ],

                  //             ),

                  //           ),
                  //           Image.asset(
                  //             'assets/images/fly_panda2x.png',
                  //             width: 130,
                  //             height: 127,
                  //           ),

                  //         ],

                  //       ),
                  //       SizedBox(height: 20.0),
                  //       RoundedButton(
                  //           width: double.infinity,
                  //           title: 'Coba Vip 1 minggu gratis!',
                  //           style: GoogleFonts.poppins(color: Colors.black,fontWeight:  FontWeight.w600,fontSize: 14.0 ),
                  //           background: Colors.white,
                  //           onClick: () {
                  //             Navigator.pushNamed(context, '/shop');
                  //           }),
                  //     ],
                  //   ),

                  //   decoration: BoxDecoration(
                  //     color: Color(0xFF9EF07B),
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  // ),

                  Image.asset(
                    'assets/images/Banner_shop4x.png',
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Toko Pandan",
                    style: GoogleFonts.poppins(
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),

                  const SizedBox(height: 20.0),
                   ShopCardItem(
                    title: 'Vip Member',
                    color:  0xffFFE590,
                      onPressed: () {},
                    description: 'dengan Vip kamu dapat beragam fitur premium',

                  ),
                  const SizedBox(height: 15.0),
                   ShopCardItem(
                    title: ' Bamboo',
                    color:  0xffCEFCDC,
                    onPressed: (){
                      Navigator.pushNamed(context, '/topup-bamboo'); 
                    },
                    iconImage:  'assets/images/bamboo.png' ,
                    description: 'kamu dapat menggunakan bamboo untuk akses ke Pandai (Pandan AI)',
                  ),
                ],
              )),
            ],
          ),
        ));
  }
}

class ShopCardItem extends StatelessWidget {
  const ShopCardItem({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.onPressed, 
    this.iconImage = 'assets/images/vip_icon.png',
  });

  final String title;
  final String description;
  final int color;
  final String iconImage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  onPressed,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD5D2D2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 81,
                height: 81,
                child: Center(
                    child: Image.asset(
                 iconImage,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )),
                decoration: BoxDecoration(
                  color:  Color(color),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 200,
                      child: Text(description, style: textRegularStyle.copyWith(color: Color(0xff979797))))
                ],
              )
            ],
          )),
    );
  }
}
