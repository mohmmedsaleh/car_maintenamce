// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:flutter/material.dart';

class ContainerTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;
  String? Function(String?)? validator;
  final TextEditingController controller;
  ContainerTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widget = widthofpage(context);
    return Container(
      width: widget / 6 * 3,
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //       color: secondaryColor), // Set your desired focus color here
            // ),
            suffixIcon: suffixIcon,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: textColor), // Set your desired focus color here
            ),
            labelText: labelText,
            hintText: hintText,
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white)),
        onTap: onTap,
        validator: validator,
      ),
    );
  }
}
