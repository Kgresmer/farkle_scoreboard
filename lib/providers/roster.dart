import '../models/RosterPlayer.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';

class Roster with ChangeNotifier {
  List<RosterPlayer> _players = [];

  List<RosterPlayer> get players {
    return [..._players];
  }

  void addPlayer(Player player) {
    _players.add(new RosterPlayer(player: player));
    notifyListeners();
  }

  void removePlayer(Player player) {
    _players.removeWhere((rp) => rp.player.id == player.id);
    notifyListeners();
  }

  void setPlayOrder(RosterPlayer rosterPlayer, int orderNum, bool active) {
    final RosterPlayer newPlayer = _players.firstWhere(
            (rp) => rp.player.id == rosterPlayer.player.id
    );
    newPlayer.playOrder = orderNum;
    newPlayer.active = active;
    notifyListeners();
  }

  void updateScore(int score) {
    RosterPlayer completedPlayer = _players.firstWhere((rp) => rp.isComplete == true, orElse: () => null);
    final isFinalRound = completedPlayer != null;
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].active == true) {
        RosterPlayer currentActive = _players[i];
        currentActive.score += score;
        currentActive.active = false;
        if (currentActive.score >= 10000 || isFinalRound) {
          currentActive.isComplete = true;
        }
        final currentPlayerOrder = currentActive.playOrder;
        RosterPlayer nextPlayerUp = _players.firstWhere((rp) => rp.playOrder == currentPlayerOrder + 1, orElse: () => null);
        if (nextPlayerUp == null) {
          nextPlayerUp = _players.firstWhere((rp) => rp.playOrder == 0);
        }
        nextPlayerUp.active = true;
        break;
      }
    }
    notifyListeners();
  }

  void addFarkle() {
    RosterPlayer completedPlayer = _players.firstWhere((rp) => rp.isComplete == true, orElse: () => null);
    final isFinalRound = completedPlayer != null;
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].active == true) {
        RosterPlayer currentActive = _players[i];
        currentActive.farkles += 1;
        if (currentActive.farkles == 3) {
          currentActive.score -= 1000;
          currentActive.farkles = 0;
        }
        currentActive.active = false;
        if (currentActive.score >= 10000 || isFinalRound) {
          currentActive.isComplete = true;
        }
        final currentPlayerOrder = currentActive.playOrder;
        RosterPlayer nextPlayerUp = _players.firstWhere((rp) => rp.playOrder == currentPlayerOrder + 1, orElse: () => null);
        if (nextPlayerUp == null) {
          nextPlayerUp = _players.firstWhere((rp) => rp.playOrder == 0);
        }
        nextPlayerUp.active = true;
        break;
      }
    }
    notifyListeners();
  }
}