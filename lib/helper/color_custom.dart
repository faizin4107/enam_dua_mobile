import 'package:flutter/material.dart';

class ColorCustome extends Color {
  static int _getColorFromHex(String flutterColor) {
    flutterColor = flutterColor.toUpperCase().replaceAll("#", "");
    if (flutterColor.length == 6) {
      flutterColor = "FF$flutterColor";
    }
    return int.parse(flutterColor, radix: 16);
  }

  ColorCustome(final String flutterColor)
      : super(_getColorFromHex(flutterColor));
}
