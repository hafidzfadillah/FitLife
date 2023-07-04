import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class TopUpBambooSuccessScreen extends StatelessWidget {
  const TopUpBambooSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: neutral60),
                        borderRadius: BorderRadius.circular(1.h)),
              child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      pause: Duration(seconds: 2000),
                      animatedTexts: [
                      TypewriterAnimatedText(
                         'Terimakasih telah membeli makanan untuk Pandan', 
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.poppins())
                    ]),
               ),
                const SizedBox(height:  30,),
                
                Image.asset('assets/images/panda_happy.png' , width:  209,height: 269,),
                const SizedBox(height:  30,),
                Text('Yeay! Top Up Berhasil', style:    GoogleFonts.poppins(fontSize:  18, fontWeight:  FontWeight.w600),),
                const SizedBox(height:  12,),
                Text('Pembelian Bamboo Dari Koin berhasil,Pandan pasti senang dengan ini', textAlign: TextAlign.center, style:  GoogleFonts.poppins(fontSize:  14, fontWeight:  FontWeight.w400 , color: Color(0xff979797)),),
                const SizedBox(height:  30,),
          RoundedButton(
                  background: primaryColor,
                  width: double.infinity,
                  title: 'Kembali ke halaman utama',
                  style: GoogleFonts.poppins(color: Colors.black),
                  onClick: () {
                    Navigator.pushNamed(context, '/topup-bamboo-success');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
