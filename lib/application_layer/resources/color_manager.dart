import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#003366");
  static Color darkPrimary = HexColor.fromHex("#0B1828");
  static Color primaryColorLight = HexColor.fromHex("#D8DCE5");
  static Color primaryColorDark = HexColor.fromHex("#FFFFFF");
  static Color darkPrimaryColorLight = HexColor.fromHex("#14213C");
  static Color darkPrimaryColorDark = HexColor.fromHex("#13274A");
  static Color accentColor = HexColor.fromHex("#2B8AF7");
  static Color lightGray = HexColor.fromHex("#AEB4BF");
  static Color grey = HexColor.fromHex("#AEB4BF");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color red = HexColor.fromHex('#AF2121');
  static Color hint = HexColor.fromHex('#B0B6C0');
  static Color green = HexColor.fromHex('#49BE00');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
