import 'package:flutter/material.dart';
import '/presentation/colors.dart';

class AppButtonsStyle {
  AppButtonsStyle._();

  static ButtonStyle outileWhiteStyle({required TextStyle textStyle}) {
    return ButtonStyle(
        textStyle: MaterialStateProperty.all(textStyle),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black45, width: 1),
            borderRadius: BorderRadius.circular(10.0))),
        foregroundColor: MaterialStateProperty.all(Colors.black54),
        backgroundColor: MaterialStateProperty.all(Colors.white));
  }

  static ButtonStyle vikingStyle({required TextStyle textStyle}) {
    return ButtonStyle(
        textStyle: MaterialStateProperty.all(textStyle),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(vikingColor));
  }
}
