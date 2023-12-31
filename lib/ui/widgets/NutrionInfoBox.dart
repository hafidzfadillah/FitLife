import 'package:flutter/material.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:fitlife/ui/widgets/NutrionRow.dart';

class NutritionInfoBox extends StatelessWidget {
  const NutritionInfoBox({
    Key? key,
    required this.carbs,
    required this.protein,
    required this.fat,
  }) : super(key: key);

  final int carbs;
  final int protein;
  final int fat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEAE7E7)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          NutrionRow(
              nutrionName: 'Karbohidrat',
              nutrionValue: carbs,
              nutrionColor: 0xff0BB576),
          SizedBox(
            height: 10,
          ),
          NutrionRow(
              nutrionName: 'Protein',
              nutrionValue: protein,
              nutrionColor: 0xffF39CFF),
          SizedBox(
            height: 10,
          ),
          NutrionRow(
              nutrionName: 'Lemak',
              nutrionValue: fat,
              nutrionColor: 0xffFFDD60,
              isLastItem: true),
        ],
      ),
    );
  }
}
