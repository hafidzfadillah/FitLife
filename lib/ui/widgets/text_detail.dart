import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextDetail extends StatelessWidget {
  const TextDetail({Key? key, required this.caption}) : super(key: key);
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      color: Colors.white,
      child: Center(
        child: Text(
          caption,
        ),
      ),
    );
  }
}
