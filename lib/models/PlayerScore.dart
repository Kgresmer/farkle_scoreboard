import 'package:flutter/foundation.dart';
import './Player.dart';

class PlayerScore {
  final Player player;
  bool active;
  int currentScore;
  int previousScore;
  int numOfFarkles;

  PlayerScore({
    @required this.player,
    @required this.active,
    @required this.currentScore,
    @required this.previousScore,
    @required this.numOfFarkles,
  });
}
