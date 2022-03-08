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

  Map toJson() => {
        'name': name,
        'id': id,
        'color': color.value,
        'wins': wins,
        'losses': losses,
        'bestScore': bestScore,
      };

  Player.load(
      this.id, this.name, this.color, this.wins, this.losses, this.bestScore);

  factory Player.fromJsonMap(dynamic data) {
    Color color = Color(data['color']);
    return Player.load(
        data['id'] as String,
        data['name'] as String,
        color,
        data['losses'],
        data['bestScore'],
        data['wins']);
  }
}
