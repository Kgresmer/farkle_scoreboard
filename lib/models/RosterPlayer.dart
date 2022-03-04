import 'package:flutter/foundation.dart';
import './Player.dart';

class RosterPlayer {
  final Player player;
  int score;
  int farkles;

  RosterPlayer({@required this.player, score = 0, farkles = 0});
}
