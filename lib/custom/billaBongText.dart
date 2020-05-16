import 'package:flutter/material.dart';

class BillaBongText extends StatelessWidget {
  final String value;
  final double fontSize;
  BillaBongText(this.value, {this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      "$value",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: "Billabong",
      ),
    );
  }
}
