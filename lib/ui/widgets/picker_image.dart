import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitlife/ui/home/theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'modal_buttom_sheet.dart';

enum PickType {
  Camera,
  Gallery,
}

class PickerImage {
  static Future<File> pickImage(PickType type) async {
    var file = await ImagePicker().pickImage(
        source:
            type == PickType.Camera ? ImageSource.camera : ImageSource.gallery);

    return File(file!.path);
  }

  /// Function to pick image from
  /// gallery or camera
  static pick(BuildContext context, Function(File) callback) {
    ModalBottomSheet.show(
      title: "Magic Scanner",
      context: context,
      radiusCircle: 40,
      children: [
        SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pickWidget(
                iconPath: "assets/images/camera.png",
                title: "Scan makanan lewat camera",
                onClick: () async {
                  await callback(await pickImage(PickType.Camera));
                  Navigator.pop(context);
                }),
            pickWidget(
                iconPath:
                  "assets/images/gallery.png",
                title: "Scan lewat gallery",
                onClick: () async {
                  await callback(await pickImage(PickType.Gallery));
                  Navigator.pop(context);
                })
          ],
        )
      ],
    );
  }

  static Widget pickWidget(
      {required String iconPath,
      required String title,
      required Function onClick}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            height: 80,
            decoration: BoxDecoration(
               color: neutral30,
              borderRadius: BorderRadius.circular(defMargin),
            ),
            child: GestureDetector(
              onTap: () => onClick(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child:  Row(
                  children: [
                    Image.asset(              iconPath, width: 30),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: normalText.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),

                    
                  ],
                )
              ),
            )),
      ],
    );
  }
}
