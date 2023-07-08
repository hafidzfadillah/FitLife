import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/ui/home/theme.dart';

class ModalBottomSheet {
  static void show({
    required String title,
    required List<Widget> children,
    required BuildContext context,
    double radiusCircle = 0,
    bool isDismisslable = true,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: isDismisslable,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusCircle),
              topRight: Radius.circular(radiusCircle))),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: normalText.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 Row(
                  children: [
                    Image.asset(
                      'assets/images/pandai_head.png',
                      width: 35,
                      height: 35,),
                    SizedBox(width: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration:  BoxDecoration(

                        border:  Border.all(color: Color(0xffE5E5E5)),
                        
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  
                      AnimatedTextKit(
                            isRepeatingAnimation: false,
                            pause: Duration(seconds: 2000),
                            animatedTexts: [
                              TypewriterAnimatedText(
                                 "Kamu bingung lagi makan apa ?  Photo saja makanan nya . pandan akan mencarikan nya untuk kamu ?",
                                  textStyle:normalText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500
                      ))
                            ]),
                    )
                  ],
                 ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
