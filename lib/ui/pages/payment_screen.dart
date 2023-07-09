import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/ui/widgets/CustomAppBar.dart';
import 'package:fitlife/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fitlife/core/models/transaction/transaction_model.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/pages/main_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/viewmodels/user/user_provider.dart';

class PaymentPage extends StatefulWidget {
  final String grossAmount;
  final String transactionId;
  final String paymentType;
  final String bank;
  final String vaNumber;
  final int expireTimeUnix;
  final String expireTimeStr;

  const PaymentPage({
    Key? key,
    required this.grossAmount,
    required this.transactionId,
    required this.paymentType,
    required this.bank,
    required this.vaNumber,
    required this.expireTimeUnix,
    required this.expireTimeStr,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPaymentVerified = false;

  @override
  Widget build(BuildContext context) {
    final formattedGrossAmount =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(double.parse(widget.grossAmount));

    final formattedExpireTime = DateFormat('dd MMMM yyyy, HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(widget.expireTimeUnix * 1000));

    if (_isPaymentVerified) {
      return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 70,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  // pop screen
                  Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPages()))
                      .then((value) {
                    if (value != null && value == true) {
                      // Refresh widget disini
                    }
                  });
                },
                label: Text("Kembali ke Home",
                    style: normalText.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                backgroundColor: primaryColor,
              )),
          appBar: AppBar(
            title: const Text('Payment Details'),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Pembayaran Berhasil",
                  style: normalText.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              Text("Terima kasih telah berlangganan Vita Premium  ",
                  textAlign: TextAlign.center,
                  style: normalText.copyWith(
                      fontSize: 16,
                      color: neutral70,
                      fontWeight: FontWeight.w500)),
            ],
          )));
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 70,
          child: FloatingActionButton.extended(
            onPressed: () async {
              final UserProvider _userProvider = UserProvider();
              TransactionModel result =
                  await _userProvider.verifyPayment(widget.transactionId);

              setState(() {
                if (result.status == 1) {
                  _isPaymentVerified = true;
                } else {
                  _isPaymentVerified = false;
                  // snackbar

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pembayaran belum diverifikasi'),
                    ),
                  );
                }
              });
            },
            label: Text("Cek Status Pembayaran",
                style: normalText.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w600)),
            backgroundColor: Color(0xffFFE590),
          )),
     appBar: CustomAppBar(
        title: ' Pembayaran ',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(
            iconColor: Color(0xffFFE590),
            onClick: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                Image.asset('assets/images/pandai_head.png', width: 35, height: 35,),
                  const SizedBox(width: 8),
                Container(
                    width:   MediaQuery.of(context).size.width * 0.78 ,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: neutral60),
                        borderRadius: BorderRadius.circular(1.h)),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        pause: Duration(seconds: 2000),
                        animatedTexts: [
                          TypewriterAnimatedText(
                               'Berikut adalah detail pembayaran kamu , pastikan kamu melakukan pembayaran sebelum $formattedExpireTime ',
                              textStyle: GoogleFonts.poppins())
                        ]),
                  ),
                 
                ],
              ),
              const SizedBox(height: 18),
             
              const SizedBox(height: 8),
               Text(
                'Detail Pembayaran ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                   Text('Metode Pembayaran: ' , style: textRegularStyle,
                ),
                
            
                  Text(widget.bank.toUpperCase() , style: GoogleFonts.poppins( 
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
             

                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  RichText(text: TextSpan(
                    text: 'VA Number : ',
                   style:  textRegularStyle,
                    children: [
                      TextSpan(
                        text: widget.vaNumber,
                        style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                      )
                    ]
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.vaNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard'),
                        ),
                      );
                    },
                    child: Icon(Icons.copy),
                  ),
                ],
              ),
              const SizedBox(height: 16),
          
              const Text(
                'Transaction Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
                  const SizedBox(height: 18),
              Text(widget.transactionId,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  )),
              const SizedBox(height: 8),
            
        
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                   Text('Total Bayar: ' , style: textRegularStyle ),
                  Text(formattedGrossAmount , style: GoogleFonts.poppins( 
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  )
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Expiration Time: ' , style: textRegularStyle ),
                  Text(formattedExpireTime, style: GoogleFonts.poppins( 
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  )

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
