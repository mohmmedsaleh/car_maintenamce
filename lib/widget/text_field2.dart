
import 'package:flutter/material.dart';

import '../responsive.dart';
import '../string/constans.dart';

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
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
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
    this.focusNode,
    this.onEditingComplete,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding * 1.5,
        vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
      ),
      // margin: const EdgeInsets.only(left: defaultPadding),
      child: TextFormField(
        focusNode: focusNode,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: black),
        autofocus: true,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: textColor,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: textColor),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: textColor), // Set your desired focus color here
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bgColor, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white)),
        onTap: onTap,
        validator: validator,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
