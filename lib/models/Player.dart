import 'package:farkle_scoreboard/models/AvatarColors.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class Player {
  String id;
  final String name;
  Color color;
  int wins;
  int losses;
  int bestScore;

  Player(
      {@required this.name,
      this.bestScore = 0,
      this.losses = 0,
      this.wins = 0}) {
    final _random = new Random();
    color = AvatarColors.getAvatarColor(_random.nextInt(10));
    id = Uuid().v4();
  }
}
