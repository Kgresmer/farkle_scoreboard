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
}