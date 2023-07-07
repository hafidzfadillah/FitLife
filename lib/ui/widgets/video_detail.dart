import 'package:expandable_text/expandable_text.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/video/video_model.dart';
import '../pages/shorts_screen.dart';

class VideoDetail extends StatelessWidget {
  final Video video;

  const VideoDetail({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
            blackColor.withOpacity(0.75),
            blackColor.withOpacity(0.5),
            blackColor.withOpacity(0.25),
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent
          ])),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ExpandableText(
            video.description ?? 'Belum ada deskripsi',
            expandText: 'Selengkapnya',
            collapseText: 'Sembunyikan',
            expandOnTextTap: false,
            collapseOnTextTap: false,
            maxLines: 2,
            linkEllipsis: false,
            linkColor: primaryColor,
            linkStyle: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w500),
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
