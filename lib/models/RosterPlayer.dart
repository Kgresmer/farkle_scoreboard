import 'package:flutter/foundation.dart';
import './Player.dart';

class RosterPlayer {
  final Player player;
  int score;
  int farkles;
  int playOrder;
  bool active;
  bool isComplete;

  RosterPlayer(
      {@required this.player,
      this.score = 0,
      this.farkles = 0,
      this.isComplete = false});
}
