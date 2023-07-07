import 'package:fitlife/ui/home/theme.dart';
import 'package:flutter/material.dart';

class TextDetail extends StatelessWidget {
  const TextDetail({Key? key, required this.caption}) : super(key: key);
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(caption, ),
      ),
    );
  }
}
