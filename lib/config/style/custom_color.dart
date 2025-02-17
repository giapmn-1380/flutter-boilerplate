import 'package:flutter/material.dart';

class CustomColor {
  static Color colorPrimary = HexColor("#2352C8");
  static Color colorTransparent = HexColor("00000000");

  // background
  static Color bgPrimary = HexColor("FFFFFF");

  // text
  static Color textPrimary = HexColor("3C3C3C");
  static Color textSecondary = HexColor("75807E");

  //shadow
  static Color shadow = HexColor("0F7A756B");

  // progress
  static Color progressFinish = colorPrimary;

  //Bottom sheet
  static Color bgBottomSheet = const Color.fromRGBO(239, 239, 244, 0.94);

  //Dialog
  static Color bgOverlayDialog = const Color.fromRGBO(0, 0, 0, 0.75);
  static Color dialogDivider = HexColor('3D3C3C43');
  static Color dialogPositiveAction = HexColor('CD000C');

  // materialColor
  static MaterialColor white = MaterialColor(
    Colors.white.value,
    const <int, Color>{
      50: Colors.white,
      100: Colors.white,
      200: Colors.white,
      300: Colors.white,
      400: Colors.white,
      500: Colors.white,
      600: Colors.white,
      700: Colors.white,
      800: Colors.white,
      900: Colors.white,
    },
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
