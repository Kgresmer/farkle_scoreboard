import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Player {
  String id;
  final String name;
  final int color;
  int wins;
  int losses;
  int bestScore;

  Player(
      {@required this.name,
      @required this.color,
      this.bestScore = 0,
      this.losses = 0,
      this.wins = 0}) {
    id = Uuid().v4();
  }
}
