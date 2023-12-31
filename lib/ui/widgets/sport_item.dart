import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fitlife/ui/home/theme.dart';

class SportItem extends StatelessWidget {
  final String title, imgAddress;
  final int durasi;
  final Function() onClick;
  final Function() onHelp;

  const SportItem(
      {super.key,
      required this.title,
      required this.durasi,
      required this.imgAddress,
      required this.onClick,
      required this.onHelp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        margin: EdgeInsets.only(bottom: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    imgAddress,
                    height: 25.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: FloatingActionButton.extended(
                      icon: Icon(
                        Icons.accessibility_new_outlined,
                        color: blackColor,
                      ),
                      backgroundColor: Colors.white70.withOpacity(0.8),
                      onPressed: onHelp,
                      label: Text(
                        'AI Guide',
                        style: GoogleFonts.poppins(color: blackColor),
                      )),
                  // child: IconButton(onPressed: onHelp, icon: Icon(Icons.help_outline, color: Colors.white,))
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: subheaderSize, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    '$durasi detik',
                    style: GoogleFonts.poppins(
                        fontSize: bodySize, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
