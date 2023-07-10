import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class TextDetail extends StatelessWidget {
  const TextDetail({Key? key, required this.title , required this.caption}) : super(key: key);
  final String caption;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackColor,
      child: ListView(
        children: [
          Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

            child: Text(
              
              title, style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              caption,
              textAlign:  TextAlign.justify,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),

        ],

        
      ),
    );
  }
}
