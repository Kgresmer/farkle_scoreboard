import 'package:flutter/foundation.dart';

class Player {
  final String name;
  final int color;
  int wins;
  int losses;
  int bestScore;

  Player(
      {@required this.name,
      @required this.color,
      this.bestScore,
      this.losses,
      this.wins});
}
