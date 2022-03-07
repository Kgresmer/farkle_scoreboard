import 'package:flutter/material.dart';

class Scoreboard with ChangeNotifier {
  int currentScore = 0;
  List<int> scoreUpdates = [];

  int get score {
    return currentScore;
  }

  void updateScore(int score) {
    currentScore += score;
    scoreUpdates.add(score);
    notifyListeners();
  }

  void clearScore() {
    currentScore = 0;
    scoreUpdates = [];
    notifyListeners();
  }

  void undoScore() {
    int lastUpdate = scoreUpdates.removeAt(scoreUpdates.length - 1);
    currentScore -= lastUpdate;
    notifyListeners();
  }
}