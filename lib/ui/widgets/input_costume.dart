import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/theme.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.isEnable = true,
    required this.state,
    required this.labelText,
    this.maxLines = 1,
    this.isSecure = false,
    this.inputType = TextInputType.text,
    this.prefixIcon , // Add the prefixIcon parameter
  }) : super(key: key);

  final int maxLines;
  final bool isEnable;
  final String hintText;
  final String labelText;
  final TextEditingController state;
  final bool isSecure;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final Widget? prefixIcon; // Define the prefixIcon variable

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: labelTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          style: TextStyle(fontSize: 14),
          inputFormatters: inputFormatters,
          validator: validator,
          controller: state,
          maxLines: maxLines,
          keyboardType: inputType,
          obscureText: isSecure ? true : false,
          enabled: isEnable,
          decoration: InputDecoration(
            fillColor: Color(0xffF0F0F0),
            filled: true,
            prefixIcon: prefixIcon, // Set the prefixIcon property
            iconColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: neutral20, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: neutral20, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: alertColor, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffEDEDED), width: 1.5),
            ),
            focusColor: Colors.red,
            labelStyle: TextStyle(color: primaryColor),
            hintText: hintText,
            contentPadding: EdgeInsets.all(24), // Added this
          ),
        ),
      ],
    );
  }
}
