import 'package:flutter/material.dart';

class Scoreboard with ChangeNotifier {
  int currentScore = 0;

  int get score {
    return currentScore;
  }

  void updateScore(int score) {
    currentScore += score;
    notifyListeners();
  }

  void clearScore() {
    currentScore = 0;
    notifyListeners();
  }
}