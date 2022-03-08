import 'package:flutter/material.dart';

class AvatarColors {
  static const List<Color> colors = const [
    Color(0xD9E2D285),
    Color(0xD98AC6BE),
    Color(0xD9C3C476),
    Color(0xD9DCC896),
    Color(0xD9FEC724),
    Color(0xD9C4C3BA),
    Color(0xD9C1DBD7),
    Color(0xD9F2CFB9),
    Color(0xD9EDAD90),
    Color(0xD9FEE3EC)
  ];

  static Color getAvatarColor(int colorNum) {
    return colors[colorNum];
  }
}
