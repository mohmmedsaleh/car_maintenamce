// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import '../string/constans.dart';

class ButtonElevated extends StatelessWidget {
  Function()? onPressed;
  String text;
  double minimumSize;
  double right;
  double left;
  ButtonElevated({
    Key? key,
    this.onPressed,
    required this.text,
    this.minimumSize = 40,
    required this.right,
    required this.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: right, left: left, top: 20, bottom: 20),
      child: minimumSize == 0
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                //shadowColor: shadowColor,
                // minimumSize: const Size.fromHeight(minimumSize),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: buttontext,
                textAlign: TextAlign.center,
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                //shadowColor: shadowColor,
                minimumSize: Size.fromHeight(minimumSize),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: buttontext,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
